//
//  NicknameViewModel.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/17/24.
//

import Foundation
import RxSwift
import RxCocoa

class NicknameViewModel: ViewModelType {
    
    var disposeBag = DisposeBag()
    
    struct Input {
        let nickname: ControlProperty<String?>
        let completeButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let nicknameValidation: Driver<Bool>
        let complete: Driver<Void>
        let error: Driver<HTTPError>
    }
    
    func transform(input: Input) -> Output {
        let nicknameValidation = PublishRelay<Bool>()
        let complete = PublishRelay<Void>()
        let errorMessage = PublishRelay<HTTPError>()
        
        input.nickname.orEmpty.changed
            .map { 2 <= $0.count && $0.count < 10 }
            .bind(to: nicknameValidation)
            .disposed(by: disposeBag)
        
        input.completeButtonTapped
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .withLatestFrom(input.nickname.orEmpty)
            .map {
                return JoinQuery(email: TempDataRepoManager.shared.email, password: TempDataRepoManager.shared.password, nick: $0)
            }
            .flatMap {
                NetworkManager.fetchToServer(model: JoinModel.self, router: UserRouter.join(JoinQuery: $0))
            }
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(_):
                    complete.accept(())
                case .failure(let error):
                    errorMessage.accept(error)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(
            nicknameValidation: nicknameValidation.asDriver(onErrorJustReturn: false), 
            complete: complete.asDriver(onErrorJustReturn: ()),
            error: errorMessage.asDriver(onErrorJustReturn: .serverError)
        )
    }
}
