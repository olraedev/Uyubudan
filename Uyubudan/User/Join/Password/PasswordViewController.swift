//
//  PasswordViewController.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/16/24.
//

import Foundation

final class PasswordViewController: JoinViewController {
    
    private let passwordView = PasswordView()
    
    override func loadView() {
        super.loadView()
        
        view = passwordView
    }
    
    override func bind() {
        passwordView.completeButton.addTarget(self, action: #selector(completeButtonClicked), for: .touchUpInside)
    }
    
    @objc func completeButtonClicked() {
        navigationController?.pushViewController(NicknameViewController(), animated: true)
    }
}
