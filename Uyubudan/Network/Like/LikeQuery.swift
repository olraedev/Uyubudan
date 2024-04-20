//
//  LikeQuery.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/20/24.
//

import Foundation

struct LikeQuery: Encodable {
    var status: Bool
    
    enum CodingKeys: String, CodingKey {
        case status = "like_status"
    }
}
