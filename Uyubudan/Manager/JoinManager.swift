//
//  JoinManager.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/17/24.
//

import UIKit

final class JoinManager {
    
    static let shared = JoinManager()
    
    private init() { }
    
    var email = ""
    var password = ""
    var nickname = ""
}
