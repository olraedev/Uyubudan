//
//  PrimaryColorButton.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/15/24.
//

import UIKit

final class PrimaryColorButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitleColor(.white, for: .normal)
        backgroundColor = .customPrimary
        layer.cornerRadius = 10
        titleLabel?.font = .systemFont(ofSize: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
