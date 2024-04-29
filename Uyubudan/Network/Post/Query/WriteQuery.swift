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
    let content1: String
    let content2: String
    let content3: String
    let productID: String
    let files: [String]?
    
    enum CodingKeys: String, CodingKey {
        case title
        case content
        case content1
        case content2
        case content3
        case productID = "product_id"
        case files
    }
}
