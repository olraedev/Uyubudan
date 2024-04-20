//
//  WriteManager.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/21/24.
//

import Foundation

final class WriteManager {
    
    static let shared = WriteManager()
    
    private init() { }
    
    var title = ""
    var content = ""
    var category = ""
    var left = ""
    var right = ""
    var productID = "uyubudan"
}
