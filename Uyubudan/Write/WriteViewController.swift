//
//  WriteViewController.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/20/24.
//

import UIKit

class WriteViewController: BaseViewController {
    
    override func configureNavigationItem() {
        super.configureNavigationItem()
        
        let popButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(popButtonClicked))
        let dismissButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissButtonClicked))
        popButton.tintColor = .black
        dismissButton.tintColor = .black
        
        navigationItem.leftBarButtonItem = popButton
        navigationItem.rightBarButtonItem = dismissButton
    }
    
    deinit {
        print("JoinViewController Deinit")
    }
}

extension WriteViewController {
    @objc func popButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissButtonClicked() {
        showAlert(title: nil, message: "종료하시겠습니까?") { [weak self] () in
            self?.dismiss(animated: true)
        }
    }
    
    func buttonColor(_ state: Bool) -> UIColor {
        return state ? .customPrimary : .lightGray
    }
}
