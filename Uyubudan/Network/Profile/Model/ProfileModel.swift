//
//  ProfileModel.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/22/24.
//

import Foundation

struct ProfileModel: Decodable {
    let userID: String
    let nickname: String
    let profileImage: String
    let posts: [String]
    let followers: [FollowInfo]
    let following: [FollowInfo]
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case nickname = "nick"
        case profileImage
        case posts
        case followers
        case following
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userID = try container.decode(String.self, forKey: .userID)
        self.nickname = try container.decode(String.self, forKey: .nickname)
        self.profileImage = try container.decodeIfPresent(String.self, forKey: .profileImage) ?? Environment.defaultImage
        self.posts = try container.decode([String].self, forKey: .posts)
        self.followers = try container.decode([FollowInfo].self, forKey: .followers)
        self.following = try container.decode([FollowInfo].self, forKey: .following)
    }
}

struct FollowInfo: Decodable {
    let userID: String
    let nickname: String
    let profileImage: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case nickname = "nick"
        case profileImage
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userID = try container.decode(String.self, forKey: .userID)
        self.nickname = try container.decode(String.self, forKey: .nickname)
        self.profileImage = try container.decodeIfPresent(String.self, forKey: .profileImage) ?? Environment.defaultImage
    }
}
