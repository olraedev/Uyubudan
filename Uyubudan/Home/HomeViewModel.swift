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
    let leftButtonClicked = PublishRelay<Int>()
    let rightButtonClicked = PublishRelay<Int>()
    let categoryClicked = BehaviorRelay(value: "전체")
    let deleteButtonClicked = PublishRelay<PostData>()
    
    let allPostList = BehaviorRelay<[PostData]>(value: [])
    let categoryPostList = BehaviorRelay<[PostData]>(value: [])
    
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
            .bind(with: self) { owner, row in
                let list = self.configureOptimisticUI(state: .left, row: row)
                owner.categoryPostList.accept(list)
            }
            .disposed(by: disposeBag)
        
        leftButtonClicked
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .flatMap {
                return NetworkManager.fetchToServer(model: LikeModel.self, router: LikeRouter.like2(postID: self.categoryPostList.value[$0].postID, LikeQuery: LikeQuery(status: false)))
            }
            .subscribe(with: self) { owner, result in }
            .disposed(by: disposeBag)
        
        leftButtonClicked
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .map {
                self.checkVote(state: .left, data: self.categoryPostList.value[$0])
            }
            .flatMap {
                print($0.1)
                return NetworkManager.fetchToServer(
                    model: LikeModel.self,
                    router: LikeRouter.like(postID: $0.0, LikeQuery: $0.1)
                )
            }
            .subscribe(with: self, onNext: { owner, result in
                switch result {
                case .success(_):
                    break
                case .failure(_): break
                }
            })
            .disposed(by: disposeBag)
        
        rightButtonClicked
            .bind(with: self) { owner, row in
                let list = self.configureOptimisticUI(state: .right, row: row)
                owner.categoryPostList.accept(list)
            }
            .disposed(by: disposeBag)
        
        rightButtonClicked
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .flatMap {
                return NetworkManager.fetchToServer(
                    model: LikeModel.self,
                    router: LikeRouter.like(postID: self.categoryPostList.value[$0].postID, LikeQuery: LikeQuery(status: false))
                )
            }
            .subscribe(with: self) { owner, result in }
            .disposed(by: disposeBag)
        
        rightButtonClicked
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .map {
                self.checkVote(state: .right, data: self.categoryPostList.value[$0])
            }
            .flatMap {
                return NetworkManager.fetchToServer(
                    model: LikeModel.self,
                    router: LikeRouter.like2(postID: $0.0, LikeQuery: $0.1)
                )
            }
            .subscribe(with: self, onNext: { owner, result in
                switch result {
                case .success(_):
                    break
                case .failure(_):
                    break
                }
            })
            .disposed(by: disposeBag)
        
        deleteButtonClicked
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .flatMap { NetworkManager.fetchToServerNoModel(router: PostRouter.delete(id: $0.postID)) }
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(_):
                    owner.viewWillAppearTrigger.accept(())
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func checkVote(state: LikeState, data: PostData) -> (String, LikeQuery) {
        let userID = UserDefaultsManager.shared.userID
        let mine = state == .left ? data.likes : data.likes2
        
        if mine.contains(userID) {
            return (data.postID, LikeQuery(status: true))
        }
        else {
            return (data.postID, LikeQuery(status: false))
        }
    }
    
    private func configureOptimisticUI(state: LikeState, row: Int) -> [PostData] {
        let userID = UserDefaultsManager.shared.userID
        var post = categoryPostList.value[row]
        let left = post.likes
        let right = post.likes2
        
        // 왼쪽을 눌렀는데
        if state == .left {
            // 이미 왼쪽이 눌려져 있는 경우 (삭제)
            if left.contains(userID) {
                post.likes.remove(at: post.likes.firstIndex(of: userID)!)
            }
            else {
                post.likes.append(userID)
            }
            
            // 오른쪽이 눌려져 있는 경우 (삭제)
            if right.contains(userID) {
                post.likes2.remove(at: post.likes2.firstIndex(of: userID)!)
            }
        }
        // 오른쪽을 눌렀는데
        if state == .right {
            // 이미 오른쪽이 눌려져 있는 경우 (삭제)
            if right.contains(userID) {
                post.likes2.remove(at: post.likes2.firstIndex(of: userID)!)
            }
            else {
                post.likes2.append(userID)
            }
            
            // 왼쪽이 눌려져 있는 경우 (삭제)
            if left.contains(userID) {
                post.likes.remove(at: post.likes.firstIndex(of: userID)!)
            }
        }
        
        var allPost = categoryPostList.value
        allPost[row] = post
        
        return allPost
    }
}
