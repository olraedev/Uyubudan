//
//  JoinViewModel.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/15/24.
//

import Foundation
import RxSwift
import RxCocoa

class JoinViewModel: ViewModelType {
    
    var disposeBag = DisposeBag()
    
    struct Input {
        let emailText: ControlProperty<String?>
        let emailValidationTapped: ControlEvent<Void>
        let passwordDiff: Observable<(ControlProperty<String?>.Element, ControlProperty<String?>.Element)>
        let completeButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let emailValidation: Driver<Bool>
        let passwordValidation: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        let emailValidation = PublishRelay<Bool>()
        let passwordDiff = PublishRelay<Bool>()
        
        input.emailText.orEmpty.changed
            .map { $0.contains("@") && $0.contains(".") }
            .bind(to: emailValidation)
            .disposed(by: disposeBag)
        
        input.emailValidationTapped
            .bind(with: self) { owner, _ in
                
            }
            .disposed(by: disposeBag)
        
        input.passwordDiff
            .map { $0.0 == $0.1 && $0.0!.count > 0 }
            .bind(to: passwordDiff)
            .disposed(by: disposeBag)
        
        return Output(
            emailValidation: emailValidation.asDriver(onErrorJustReturn: false),
            passwordValidation: passwordDiff.asDriver(onErrorJustReturn: false)
        )
    }
}
