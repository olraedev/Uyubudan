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
                let validationText = state ? "사용 가능한 비밀번호입니다." : "4글자 이상 15글자 미만으로 입력해주세요."
                
                owner.passwordView.validationLabel.text = validationText
                owner.passwordView.validationLabel.textColor = JoinManager.shared.textColor(state)
                
                owner.passwordView.completeButton.isEnabled = state
                owner.passwordView.completeButton.backgroundColor = JoinManager.shared.buttonColor(state)
            }
            .disposed(by: disposeBag)
        
        completeButtonTapped
            .withLatestFrom(password.orEmpty)
            .bind(with: self) { owner, password in
                JoinManager.shared.password = password
                owner.navigationController?.pushViewController(NicknameViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
}
