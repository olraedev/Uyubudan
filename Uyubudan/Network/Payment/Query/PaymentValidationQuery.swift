//
//  ValidationQuery.swift
//  Uyubudan
//
//  Created by SangRae Kim on 5/2/24.
//

import Foundation

struct PaymentValidationQuery: Encodable {
    let impUID: String
    let postID: String
    let productName: String
    let price: Int
    
    enum CodingKeys: String, CodingKey {
        case impUID = "imp_uid"
        case postID = "post_id"
        case productName
        case price
    }
}
