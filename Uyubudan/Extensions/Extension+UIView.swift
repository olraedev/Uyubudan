//
//  Extension+UIView.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/14/24.
//

import UIKit

extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var deviceWidth: CGFloat {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return 0 }
         
        return window.screen.bounds.width
    }
}
