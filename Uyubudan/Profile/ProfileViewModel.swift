//
//  MypageViewModel.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/22/24.
//

import Foundation
import RxSwift
import RxCocoa

final class ProfileViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    
    var profileState: ProfileState = .mine
    var userID = ""
    let viewWillAppearTrigger = PublishRelay<Void>()
    let profileInfo = PublishRelay<ProfileModel>()
    let withdrawButtonTapped = PublishRelay<Void>()
    let myFollowingList = BehaviorRelay<[String]>(value: [])
    
    struct Input {
        let segmentChanged: ControlProperty<Int>
    }
    
    struct Output {
        let posts: Driver<[PostData]>
        let successWithdraw: Driver<Bool>
        let errorMessage: Driver<HTTPError>
    }
    
    func transform(input: Input) -> Output {
        let posts = PublishRelay<[PostData]>()
        let myPosts = PublishRelay<Bool>()
        let likePosts = PublishRelay<Bool>()
        let successWithdraw = PublishRelay<Bool>()
        let errorMessage = PublishRelay<HTTPError>()
        
        viewWillAppearTrigger
            .filter { self.profileState == .mine }
            .flatMap { NetworkManager.fetchToServer(model: ProfileModel.self, router: ProfileRouter.read) }
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let model):
                    owner.profileInfo.accept(model)
                    owner.myFollowingList.accept(model.following.map { $0.userID })
                    myPosts.accept(true)
                case .failure(let error):
                    errorMessage.accept(error)
                }
            }
            .disposed(by: disposeBag)
        
        viewWillAppearTrigger
            .filter { self.profileState == .other }
            .flatMap { NetworkManager.fetchToServer(model: ProfileModel.self, router: ProfileRouter.readSpecific(userID: self.userID)) }
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let model):
                    owner.profileInfo.accept(model)
                    myPosts.accept(true)
                case .failure(let error):
                    errorMessage.accept(error)
                }
            }
            .disposed(by: disposeBag)
        
        viewWillAppearTrigger
            .filter { self.profileState == .other }
            .flatMap { _ in NetworkManager.fetchToServer(model: ProfileModel.self, router: ProfileRouter.read) }
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let model):
                    owner.myFollowingList.accept(model.following.map { $0.userID })
                case .failure(let error):
                    errorMessage.accept(error)
                }
            }
            .disposed(by: disposeBag)
        
        input.segmentChanged.bind(with: self) { owner, index in
            if index == 0 { myPosts.accept(true) }
            else { likePosts.accept(true) }
        }
        .disposed(by: disposeBag)
        
        myPosts
            .withLatestFrom(profileInfo)
            .flatMap {
                NetworkManager.fetchToServer(model: ReadAllModel.self, router: PostRouter.readSpecificUser(userID:$0.userID, nextCursor: ""))
            }
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let model):
                    posts.accept(model.data)
                case .failure(let error):
                    errorMessage.accept(error)
                }
            }
            .disposed(by: disposeBag)
        
        likePosts
            .flatMap { _ in
                Single.zip(NetworkManager.fetchToServer(model: ReadAllModel.self, router: LikeRouter.likeMe), NetworkManager.fetchToServer(model: ReadAllModel.self, router: LikeRouter.like2Me))
            }
            .subscribe(with: self) { owner, result in
                var results: [PostData] = []
                
                switch result.0 {
                case .success(let model):
                    results.append(contentsOf: model.data)
                case .failure(let error):
                    errorMessage.accept(error)
                }
                
                switch result.1 {
                case .success(let model):
                    results.append(contentsOf: model.data)
                case .failure(let error):
                    errorMessage.accept(error)
                }
                
                posts.accept(results)
            }
            .disposed(by: disposeBag)
        
        withdrawButtonTapped
            .flatMap { NetworkManager.fetchToServer(model: JoinModel.self, router: UserRouter.withdraw)}
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(_):
                    successWithdraw.accept(true)
                case .failure(let error):
                    errorMessage.accept(error)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(
            posts: posts.asDriver(onErrorJustReturn: []), 
            successWithdraw: successWithdraw.asDriver(onErrorJustReturn: false), 
            errorMessage: errorMessage.asDriver(onErrorJustReturn: .serverError)
        )
    }
}
