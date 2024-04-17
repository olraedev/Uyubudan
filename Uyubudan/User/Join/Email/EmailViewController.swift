//
//  EmailViewController.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/15/24.
//

import UIKit
import RxSwift
import RxCocoa

final class EmailViewController: JoinViewController {
    
    private let emailView = EmailView()
    private let viewModel = EmailViewModel()
    
    override func loadView() {
        super.loadView()
        
        view = emailView
    }
    
    override func configureNavigationItem() {
        super.configureNavigationItem()
        
        navigationItem.leftBarButtonItem?.isHidden = true
    }
    
    override func bind() {
        let email = emailView.emailTextField.rx.text
        let validationButtonTapped = emailView.validationButton.rx.tap
        let completeButtonTapped = emailView.completeButton.rx.tap
        
        let input = EmailViewModel.Input(
            email: email,
            validationButtonTapped: validationButtonTapped
        )
        let output = viewModel.transform(input: input)
        
        // 이메일 형식이 맞는지? -> Bool
        output.emailRegex
            .drive(with: self) { owner, state in
                let buttonColor: UIColor = state ? .customPrimary : .lightGray
                let textColor: UIColor = state ? .customPrimary : .systemRed
                let text = state ? "중복확인을 해주세요." : "이메일 주소를 정확하게 입력해주세요."
                
                owner.emailView.validationButton.isEnabled = state
                owner.emailView.validationButton.backgroundColor = buttonColor
                
                owner.emailView.validationLabel.textColor = textColor
                owner.emailView.validationLabel.text = text
            }
            .disposed(by: disposeBag)
        
        // 중복 확인 -> Bool
        output.validation
            .drive(with: self) { owner, state in
                let textColor: UIColor = state ? .customPrimary : .systemRed
                let buttonColor: UIColor = state ? .customPrimary : .lightGray
                
                owner.emailView.completeButton.isEnabled = state
                owner.emailView.completeButton.backgroundColor = buttonColor
                
                owner.emailView.validationLabel.textColor = textColor
            }
            .disposed(by: disposeBag)
        
        output.validationMessage
            .drive(emailView.validationLabel.rx.text)
            .disposed(by: disposeBag)
        
        completeButtonTapped
            .withLatestFrom(email.orEmpty)
            .bind(with: self) { owner, text in
                JoinManager.shared.email = text
                owner.navigationController?.pushViewController(PasswordViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
}
