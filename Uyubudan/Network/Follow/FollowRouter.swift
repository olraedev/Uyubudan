//
//  FollowRouter.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/25/24.
//

import Foundation
import Alamofire

enum FollowRouter {
    case follow(userID: String)
    case cancel(userID: String)
}

extension FollowRouter: TargetType {
    var baseURL: String {
        return Environment.baseURL
    }
    
    var version: String {
        return Version.v1.rawValue
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .follow: .post
        case .cancel: .delete
        }
    }
    
    var path: String {
        switch self {
        case .follow(let userID), .cancel(let userID):
            "/follow/\(userID)"
        }
    }
    
    var header: [String : String] {
        return [HTTPHeader.sesacKey.rawValue: Environment.secretKey]
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var body: Data? {
        return nil
    }
}
