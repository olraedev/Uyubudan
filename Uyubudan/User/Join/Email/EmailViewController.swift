//
//  EmailViewController.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/15/24.
//

import UIKit

final class EmailViewController: JoinViewController {
    
    private let emailView = EmailView()
    
    override func loadView() {
        super.loadView()
        
        view = emailView
    }
    
    override func configureNavigationItem() {
        super.configureNavigationItem()
        
        navigationItem.leftBarButtonItem?.isHidden = true
    }
    
    override func bind() {
        emailView.completeButton.addTarget(self, action: #selector(completeButtonClicked), for: .touchUpInside)
    }
    
    @objc func completeButtonClicked() {
        navigationController?.pushViewController(PasswordViewController(), animated: true)
    }
}
