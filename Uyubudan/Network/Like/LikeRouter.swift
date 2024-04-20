//
//  LikeRouter.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/20/24.
//

import Foundation
import Alamofire

enum LikeRouter {
    case like(postID: String, LikeQuery: Encodable)
    case likeMe
    case like2(postID: String, LikeQuery: Encodable)
    case like2Me
}

extension LikeRouter: TargetType {
    var baseURL: String {
        return Environment.baseURL
    }
    
    var version: String {
        return Version.v1.rawValue
    }
    
    var method: HTTPMethod {
        switch self {
        case .like, .like2: .post
        case .likeMe, .like2Me: .get
        }
    }
    
    var path: String {
        switch self {
        case .like(let postID, _): "/posts/\(postID)/like"
        case .likeMe: "/posts/likes/me"
        case .like2(let postID, _): "/posts/\(postID)/like-2"
        case .like2Me: "/posts/likes-2/me"
        }
    }
    
    var header: [String : String] {
        return [HTTPHeader.sesacKey.rawValue: Environment.secretKey,
                HTTPHeader.contentType.rawValue: HTTPHeader.json.rawValue]
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var body: Data? {
        let encoder = JSONEncoder()
        
        switch self {
        case .like(_, let query), .like2(_, let query):
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(query)
        default: return nil
        }
    }
}
