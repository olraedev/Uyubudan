//
//  JoinManager.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/17/24.
//

import UIKit

class JoinManager {
    
    static let shared = JoinManager()
    
    private init() { }
    
    var email = ""
    var password = ""
    var nickname = ""
    
    func textColor(_ state: Bool) -> UIColor {
        return state ? .customPrimary : .systemRed
    }
    
    func buttonColor(_ state: Bool) -> UIColor {
        return state ? .customPrimary : .lightGray
    }
}
