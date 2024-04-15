//
//  JoinViewController.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/15/24.
//

import UIKit

class JoinViewController: BaseViewController {
    
    override func configureNavigationItem() {
        super.configureNavigationItem()
        
        let dismissButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissButtonClicked))
        dismissButton.tintColor = .black
        
        navigationItem.rightBarButtonItem = dismissButton
    }
}

extension JoinViewController {
    @objc func dismissButtonClicked() {
        dismiss(animated: true)
    }
}
