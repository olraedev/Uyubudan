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
    let categories = BehaviorRelay(value: ["전체", "작명", "메뉴", "쇼핑", "여행", "기타"])
    
    let viewWillAppearTrigger = PublishRelay<Void>()
    let leftButtonClicked = PublishRelay<PostData>()
    let rightButtonClicked = PublishRelay<PostData>()
    let categoryClicked = BehaviorRelay(value: "전체")
    
    let allPostList = PublishRelay<[PostData]>()
    let categoryPostList = PublishRelay<[PostData]>()
    
    init() {
        viewWillAppearTrigger
            .flatMap { _ in
                return NetworkManager.fetchToServer(model: ReadAllModel.self, router: PostRouter.readAll)
            }
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let model):
                    print("전체 데이터 가져오기 성공!")
                    owner.allPostList.accept(model.data)
                    owner.categoryClicked.accept(owner.categoryClicked.value)
                case .failure(_): break
                }
            }
            .disposed(by: disposeBag)
        
        categoryClicked
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .withLatestFrom(allPostList)
            .bind(with: self) { owner, lists in
                print("change category: \(owner.categoryClicked.value)")
                if owner.categoryClicked.value == "전체" {
                    owner.categoryPostList.accept(lists)
                } else {
                    owner.categoryPostList
                        .accept(lists.filter {
                            $0.content3 == owner.categoryClicked.value
                        })
                }
                owner.categories.accept(owner.categories.value)
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
                case .success(_):
                    owner.viewWillAppearTrigger.accept(())
                case .failure(_): break
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
                case .success(_):
                    owner.viewWillAppearTrigger.accept(())
                case .failure(_):
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
