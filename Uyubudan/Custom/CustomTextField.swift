//
//  CustomTextField.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/15/24.
//

import UIKit

final class CustomTextField: UITextField {
    
    let placeHolder: String?
    
    init(placeHolder: String) {
        self.placeHolder = placeHolder
        super.init(frame: .zero)
        
        placeholder = placeHolder
        borderStyle = .roundedRect
        autocapitalizationType = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
