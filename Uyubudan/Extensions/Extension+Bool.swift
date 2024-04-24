//
//  Extension+UIColor.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/24/24.
//

import UIKit

extension Bool {
    var textColor: UIColor {
        return self ? .customPrimary : .systemRed
    }
    
    var buttonColor: UIColor {
        return self ? .customPrimary : .lightGray
    }
}
