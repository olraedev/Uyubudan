//
//  ReadAllModel.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/18/24.
//

import Foundation

struct ReadAllModel: Decodable {
    let data: [PostData]
}

struct PostData: Decodable {
    let postID: String
    let productID: String
    let title: String
    let content: String
    let content1: String
    let content2: String
    let content3: String
    let createdAt: String
    let creator: Creator
    var likes: [String]
    var likes2: [String]
    let files: [String]
    let hashTags: [String]
    let comments: [Comment]
    
    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case productID = "product_id"
        case title
        case content
        case content1
        case content2
        case content3
        case createdAt
        case creator
        case likes
        case likes2
        case files
        case hashTags
        case comments
    }
}

struct Comment: Decodable {
    let commentID: String
    let content: String
    let createdAt: String
    let creator: Creator
    
    enum CodingKeys: String, CodingKey {
        case commentID = "comment_id"
        case content
        case createdAt
        case creator
    }
}

struct Creator: Decodable {
    let userID: String
    let nick: String
    let profileImage: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case nick
        case profileImage
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userID = try container.decode(String.self, forKey: .userID)
        self.nick = try container.decode(String.self, forKey: .nick)
        self.profileImage = try container.decodeIfPresent(String.self, forKey: .profileImage) ?? Environment.defaultImage
    }
}
