//
//  TempDataRepoManager.swift
//  Uyubudan
//
//  Created by SangRae Kim on 5/1/24.
//

import Foundation

final class TempDataRepoManager {
    
    static let shared = TempDataRepoManager()
    private init() { }
    
    var email = ""
    var password = ""
    var nickname = ""
    var title = ""
    var content = ""
    var content1 = ""
    var content2 = ""
    var content3 = ""
    var productID = "uyubudan"
    var files: [String] = []
}
