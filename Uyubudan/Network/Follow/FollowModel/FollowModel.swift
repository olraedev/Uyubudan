//
//  FollowModel.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/25/24.
//

import Foundation

struct FollowModel: Decodable {
    let nickname: String
    let opponent: String
    let status: Bool
    
    enum CodingKeys: String, CodingKey {
        case nickname = "nick"
        case opponent = "opponent_nick"
        case status = "following_status"
    }
}
