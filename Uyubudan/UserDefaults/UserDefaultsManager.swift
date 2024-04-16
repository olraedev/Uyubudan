//
//  UserDefaultsManager.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/16/24.
//

import Foundation

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    private let ud = UserDefaults.standard
    
    private init() { }
    
    private enum Key {
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
    }
    
    var accessToken: String? {
        get { ud.string(forKey: Key.accessToken) }
        set { ud.setValue(newValue, forKey: Key.accessToken) }
    }
    
    var refreshToken: String? {
        get { ud.string(forKey: Key.refreshToken) }
        set { ud.setValue(newValue, forKey: Key.refreshToken) }
    }
}
