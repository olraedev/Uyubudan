//
//  UserDefaultsManager.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/16/24.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: key)
        }
    }
}

enum UserDefaultsManager {
    
    enum Key: String {
        case userID
        case accessToken
        case refreshToken
        case profileImage
    }
    
    @UserDefault(key: Key.userID.rawValue, defaultValue: "")
    static var userID
    
    @UserDefault(key: Key.accessToken.rawValue, defaultValue: "")
    static var accessToken
    
    @UserDefault(key: Key.refreshToken.rawValue, defaultValue: "")
    static var refreshToken
    
    @UserDefault(key: Key.profileImage.rawValue, defaultValue: Environment.defaultImage)
    static var profileImage
    
    static func removeAll() {
        UserDefaults.standard.removeObject(forKey: Key.userID.rawValue)
        UserDefaults.standard.removeObject(forKey: Key.accessToken.rawValue)
        UserDefaults.standard.removeObject(forKey: Key.refreshToken.rawValue)
        UserDefaults.standard.removeObject(forKey: Key.profileImage.rawValue)
    }
}
