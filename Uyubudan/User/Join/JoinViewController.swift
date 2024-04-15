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
    
    deinit {
        print("JoinViewController Deinit")
    }
}

extension JoinViewController {
    @objc func dismissButtonClicked() {
        showAlert(title: nil, message: "종료하시겠습니까?") { [weak self] () in
            self?.dismiss(animated: true)
        }
    }
}
