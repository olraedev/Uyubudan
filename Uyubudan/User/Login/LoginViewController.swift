//
//  LoginViewController.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/15/24.
//

import UIKit
import RxSwift
import RxCocoa
import Toast

final class LoginViewController: BaseViewController {
    
    private let loginView = LoginView()
    private let viewModel = LoginViewModel()
    
    override func loadView() {
        super.loadView()
        
        view = loginView
    }
    
    override func configureNavigationItem() {
        super.configureNavigationItem()
        
        navigationItem.leftBarButtonItem?.isHidden = true
    }
    
    override func bind() {
        let email = loginView.emailTextField.rx.text
        let password = loginView.passwordTextField.rx.text
        let loginButtonTapped = loginView.loginButton.rx.tap
        
        let input = LoginViewModel.Input(
            email: email,
            password: password,
            loginButtonTapped: loginButtonTapped
        )
        
        let output = viewModel.transform(input: input)
        
        output.success
            .drive(with: self) { owner, nickName in
                owner.view.makeToast("\(nickName)님 환영합니다", duration: 1)
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                let nav = TabViewController()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    sceneDelegate?.window?.rootViewController = nav
                    sceneDelegate?.window?.makeKeyAndVisible()
                }
            }
            .disposed(by: disposeBag)
        
        output.errorInfo
            .drive(with: self) { owner, error in
                if error == .checkAccount {
                    owner.showAlert(title: nil, message: "계정을 확인해주세요")
                }
            }
            .disposed(by: disposeBag)
        
        loginView.joinButton.rx.tap.bind(with: self) { owner, _ in
            let vc = UINavigationController(rootViewController: EmailViewController())
            
            vc.modalPresentationStyle = .fullScreen
            owner.present(vc, animated: true)
        }
        .disposed(by: disposeBag)
    }
    
    deinit {
        print("LoginViewController Deinit")
    }
}
