//
//  WriteQuery.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/18/24.
//

import Foundation

struct WriteQuery: Encodable {
    let title: String
    let content: String
    let productID: String
    let files: [String]?
    
    enum CodingKeys: String, CodingKey {
        case title
        case content
        case productID = "product_id"
        case files
    }
}
