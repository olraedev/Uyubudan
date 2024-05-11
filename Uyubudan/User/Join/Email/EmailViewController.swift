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
                owner.emailView.designViewWithEmailRegex(state: state)
            }
            .disposed(by: disposeBag)
        
        // 중복 확인 -> Bool
        output.validation
            .drive(with: self) { owner, state in
                owner.emailView.designViewWithEmailValidation(state: state)
            }
            .disposed(by: disposeBag)
        
        output.validationMessage
            .drive(emailView.validationLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.error
            .drive(with: self) { owner, error in
                owner.showAlert(title: nil, message: error.localizedDescription)
            }
            .disposed(by: disposeBag)
        
        completeButtonTapped
            .withLatestFrom(email.orEmpty)
            .bind(with: self) { owner, text in
                TempDataRepoManager.shared.email = text
                owner.pushNavigation(PasswordViewController())
            }
            .disposed(by: disposeBag)
    }
    
    deinit {
        print("Email Deinit")
    }
}
