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
    
    struct Input {
        
    }
    
    struct Output {
        let profileInfo: PublishRelay<ProfileModel>
        let posts: Driver<[String]>
    }
    
    func transform(input: Input) -> Output {
        let profileInfo = PublishRelay<ProfileModel>()
        let posts = PublishRelay<[String]>()
        
        viewWillAppearTrigger
            .flatMap { NetworkManager.fetchToServer(model: ProfileModel.self, router: ProfileRouter.read) }
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let model):
                    profileInfo.accept(model)
                    posts.accept(model.posts)
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(
            profileInfo: profileInfo,
            posts: posts.asDriver(onErrorJustReturn: [])
        )
    }
}
