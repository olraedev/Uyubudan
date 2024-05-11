//
//  PasswordViewController.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/16/24.
//

import UIKit
import RxSwift
import RxCocoa

final class PasswordViewController: JoinViewController {
    
    private let passwordView = PasswordView()
    private let viewModel = PasswordViewModel()
    
    override func loadView() {
        super.loadView()
        
        view = passwordView
    }
    
    override func bind() {
        let password = passwordView.passwordTextField.rx.text
        let completeButtonTapped = passwordView.completeButton.rx.tap
        
        let input = PasswordViewModel.Input(
            password: password
        )
        let output = viewModel.transform(input: input)
        
        output.passwordValidation
            .drive(with: self) { owner, state in
                owner.passwordView.designViewWithPasswordValidation(state: state)
            }
            .disposed(by: disposeBag)
        
        completeButtonTapped
            .withLatestFrom(password.orEmpty)
            .bind(with: self) { owner, password in
                TempDataRepoManager.shared.password = password
                owner.pushNavigation(NicknameViewController())
            }
            .disposed(by: disposeBag)
    }
    
    deinit {
        print("Password Deinit")
    }
}
