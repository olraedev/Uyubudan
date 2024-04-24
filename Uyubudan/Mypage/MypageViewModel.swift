//
//  MypageViewModel.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/22/24.
//

import Foundation
import RxSwift
import RxCocoa

final class MypageViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    
    let viewWillAppearTrigger = PublishRelay<Void>()
    var profileInfo = PublishRelay<ProfileModel>()
    
    struct Input {
        let segmentChanged: ControlProperty<Int>
    }
    
    struct Output {
        let posts: Driver<[PostData]>
    }
    
    func transform(input: Input) -> Output {
        let posts = PublishRelay<[PostData]>()
        let myPosts = PublishRelay<Bool>()
        let likePosts = PublishRelay<Bool>()
        
        viewWillAppearTrigger
            .flatMap { NetworkManager.fetchToServer(model: ProfileModel.self, router: ProfileRouter.read) }
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let model):
                    owner.profileInfo.accept(model)
                    myPosts.accept(true)
                case .failure(let error):
                    print(error)
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
                NetworkManager.fetchToServer(model: ReadAllModel.self, router: PostRouter.readSpecificUser(userID:$0.userID ))
            }
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let model):
                    posts.accept(model.data)
                case .failure(let error):
                    print(error)
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
                    print(error)
                }
                
                switch result.1 {
                case .success(let model):
                    results.append(contentsOf: model.data)
                case .failure(let error):
                    print(error)
                }
                
                posts.accept(results)
            }
            .disposed(by: disposeBag)
        
        
        return Output(
            posts: posts.asDriver(onErrorJustReturn: [])
        )
    }
}
