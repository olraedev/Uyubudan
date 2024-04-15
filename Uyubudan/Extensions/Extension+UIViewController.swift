//
//  Extension+UIViewController.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/16/24.
//

import UIKit

extension UIViewController {
    func showAlert(title: String?, message: String?, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .destructive) { _ in
            completionHandler()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(confirm)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}
