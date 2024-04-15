//
//  LoginViewController.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/15/24.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginViewController: BaseViewController {
    
    private let loginView = LoginView()
    
    override func loadView() {
        super.loadView()
        
        view = loginView
    }
    
    override func configureNavigationItem() {
        super.configureNavigationItem()
    }
    
    override func bind() {
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
