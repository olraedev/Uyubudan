//
//  HistoryModel.swift
//  Uyubudan
//
//  Created by SangRae Kim on 5/2/24.
//

import Foundation

struct HistoryModel: Decodable {
    let data: [HistoryData]
}

struct HistoryData: Decodable {
    let paymentID: String
    let buyerID: String
    let postID: String
    let merchantUID: String
    let productName: String
    let price: Int
    let paidAt: String
    
    enum CodingKeys: String, CodingKey {
        case paymentID = "payment_id"
        case buyerID = "buyer_id"
        case postID = "post_id"
        case merchantUID = "merchant_uid"
        case productName
        case price
        case paidAt
    }
}
