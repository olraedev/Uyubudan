//
//  HomeViewModel.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/18/24.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: ViewModelType {
    
    var disposeBag = DisposeBag()
    
    struct Input {
        let viewWillAppearTrigger: ControlEvent<Bool>
    }
    
    struct Output {
        let allPostList: Driver<[PostData]>
    }
    
    func transform(input: Input) -> Output {
        let allPostList = PublishRelay<[PostData]>()
        
        input.viewWillAppearTrigger
            .flatMap { _ in
                return NetworkManager.fetchToServer(model: ReadAllModel.self, router: PostRouter.readAll)
            }
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let model):
                    print("post read success")
                    allPostList.accept(model.data)
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(allPostList: allPostList.asDriver(onErrorJustReturn: []))
    }
}
