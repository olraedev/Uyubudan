//
//  UserDefaultsManager.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/16/24.
//

import Foundation

final class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    private let ud = UserDefaults.standard
    
    private init() { }
    
    private enum Key {
        static let userID = "userID"
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
        static let profileImage = "profileImage"
    }
    
    var userID: String {
        get { ud.string(forKey: Key.userID) ?? "" }
        set { ud.setValue(newValue, forKey: Key.userID) }
    }
    
    var accessToken: String {
        get { ud.string(forKey: Key.accessToken) ?? "" }
        set { ud.setValue(newValue, forKey: Key.accessToken) }
    }
    
    var refreshToken: String {
        get { ud.string(forKey: Key.refreshToken) ?? "" }
        set { ud.setValue(newValue, forKey: Key.refreshToken) }
    }
    
    var profileImage: String {
        get { ud.string(forKey: Key.profileImage) ?? "uploads/posts/person@3x_1713616487566.png"}
        set { ud.setValue(newValue, forKey: Key.profileImage)}
    }
}
