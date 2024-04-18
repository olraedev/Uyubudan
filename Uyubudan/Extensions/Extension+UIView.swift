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
    
    func addSubViews(_ views: [UIView]) {
        for view in views {
            self.addSubview(view)
        }
    }
    
    func percentage(a: Int, b: Int) -> Double {
        if a + b == 0 { return 0.0 }
        
        return (Double(a) / (Double(a + b)) * 100)
    }
}
