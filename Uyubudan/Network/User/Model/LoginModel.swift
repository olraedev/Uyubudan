//
//  LoginModel.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/16/24.
//

import Foundation

struct LoginModel: Decodable {
    let userID: String
    let nickName: String
    let profileImage: String
    let accessToken: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case nickName = "nick"
        case profileImage
        case accessToken
        case refreshToken
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.userID = try container.decode(String.self, forKey: .userID)
        self.nickName = try container.decode(String.self, forKey: .nickName)
        self.profileImage = try container.decodeIfPresent(String.self, forKey: .profileImage) ?? Environment.defaultImage
        self.accessToken = try container.decode(String.self, forKey: .accessToken)
        self.refreshToken = try container.decode(String.self, forKey: .refreshToken)
    }
}
