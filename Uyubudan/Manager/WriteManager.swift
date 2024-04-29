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
    var content1 = ""
    var content2 = ""
    var content3 = ""
    var productID = "uyubudan"
    var files: [String] = []
}
