//
//  EmailViewModel.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/17/24.
//

import Foundation
import RxSwift
import RxCocoa

final class EmailViewModel: ViewModelType {
    
    var disposeBag = DisposeBag()
    
    struct Input {
        let email: ControlProperty<String?>
        let validationButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let emailRegex: Driver<Bool>
        let validation: Driver<Bool>
        let validationMessage: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        let emailRegex = PublishRelay<Bool>()
        let validation = PublishRelay<Bool>()
        let validationMessage = PublishRelay<String>()
        
        input.email.orEmpty.changed
            .map { [weak self] email in
                guard let self else { return false }
                validation.accept(false)
                return self.checkEmailRegex(str: email)
            }
            .bind(to: emailRegex)
            .disposed(by: disposeBag)
        
        input.validationButtonTapped
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .withLatestFrom(input.email.orEmpty)
            .map {
                EmailValidationQuery(email: $0)
            }
            .flatMap {
                NetworkManager.fetchToServer(model: MessageModel.self, router: UserRouter.emailValidation(EmailValidationQuery: $0))
            }
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let model):
                    validationMessage.accept(model.message)
                    validation.accept(true)
                case .failure(_):
                    validationMessage.accept("사용이 불가한 이메일입니다.")
                    validation.accept(false)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(
            emailRegex: emailRegex.asDriver(onErrorJustReturn: false),
            validation: validation.asDriver(onErrorJustReturn: false),
            validationMessage: validationMessage.asDriver(onErrorJustReturn: "")
        )
    }
    
    private func checkEmailRegex(str: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        
        return  NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: str)
    }
}
