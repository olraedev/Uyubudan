//
//  LikeModel.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/20/24.
//

import Foundation

struct LikeModel: Decodable {
    let status: Bool
    
    enum CodingKeys: String, CodingKey {
        case status = "like_status"
    }
}
