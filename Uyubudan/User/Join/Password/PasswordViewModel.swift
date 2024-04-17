//
//  PasswordViewModel.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/17/24.
//

import Foundation
import RxSwift
import RxCocoa

class PasswordViewModel: ViewModelType {
    
    var disposeBag = DisposeBag()
    
    struct Input {
        let password: ControlProperty<String?>
    }
    
    struct Output {
        let passwordValidation: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        let passwordValidation = PublishRelay<Bool>()
        
        input.password.orEmpty.changed
            .map { 4 <= $0.count && $0.count < 15 }
            .bind(to: passwordValidation)
            .disposed(by: disposeBag)
        
        return Output(
            passwordValidation: passwordValidation.asDriver(onErrorJustReturn: false)
        )
    }
}
