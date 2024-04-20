//
//  HomeViewModel.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/18/24.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeViewModel {
    
    private let disposeBag = DisposeBag()
    
    let viewWillAppearTrigger = PublishRelay<Void>()
    let leftButtonClicked = PublishRelay<PostData>()
    let rightButtonClicked = PublishRelay<PostData>()
    
    let allPostList = PublishRelay<[PostData]>()
    
    init() {
        viewWillAppearTrigger
            .flatMap { _ in
                return NetworkManager.fetchToServer(model: ReadAllModel.self, router: PostRouter.readAll)
            }
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let model):
                    owner.allPostList.accept(model.data)
                case .failure(_): break
                }
            }
            .disposed(by: disposeBag)
        
        leftButtonClicked
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .flatMap {
                return NetworkManager.fetchToServer(model: LikeModel.self, router: LikeRouter.like2(postID: $0.postID, LikeQuery: LikeQuery(status: false)))
            }
            .subscribe(with: self) { owner, result in }
            .disposed(by: disposeBag)
        
        leftButtonClicked
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .map {
                self.checkVote(state: .left, data: $0)
            }
            .flatMap {
                return NetworkManager.fetchToServer(model: LikeModel.self, router: LikeRouter.like(postID: $0.0, LikeQuery: $0.1))
            }
            .subscribe(with: self, onNext: { owner, result in
                switch result {
                case .success(let model):
                    owner.viewWillAppearTrigger.accept(())
                case .failure(let error): break
                }
            })
            .disposed(by: disposeBag)
        
        rightButtonClicked
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .flatMap {
                return NetworkManager.fetchToServer(model: LikeModel.self, router: LikeRouter.like(postID: $0.postID, LikeQuery: LikeQuery(status: false)))
            }
            .subscribe(with: self) { owner, result in }
            .disposed(by: disposeBag)
        
        rightButtonClicked
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .map {
                self.checkVote(state: .right, data: $0)
            }
            .flatMap {
                return NetworkManager.fetchToServer(model: LikeModel.self, router: LikeRouter.like2(postID: $0.0, LikeQuery: $0.1))
            }
            .subscribe(with: self, onNext: { owner, result in
                switch result {
                case .success(let model):
                    owner.viewWillAppearTrigger.accept(())
                case .failure(let error):
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func checkVote(state: LikeState, data: PostData) -> (String, LikeQuery) {
        let userID = UserDefaultsManager.shared.userID
        let mine = state == .left ? data.likes : data.likes2
        
        if mine.contains(userID) {
            return (data.postID, LikeQuery(status: false))
        }
        else { return (data.postID, LikeQuery(status: true)) }
    }
}
