//
//  CommentsRouter.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/22/24.
//

import Foundation
import Alamofire

enum CommentsRouter {
    case write(postID: String, CommentsWriteQuery: Encodable)
    case delete(postID: String, commentID: String)
}

extension CommentsRouter: TargetType {
    var baseURL: String {
        return Environment.baseURL
    }
    
    var version: String {
        return Version.v1.rawValue
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .write: .post
        case .delete: .delete
        }
    }
    
    var path: String {
        switch self {
        case .write(let postID, _): "/posts/\(postID)/comments"
        case .delete(let postID, let commentID): "/posts/\(postID)/comments/\(commentID)"
        }
    }
    
    var header: [String : String] {
        return [HTTPHeader.contentType.rawValue: HTTPHeader.json.rawValue,
                HTTPHeader.sesacKey.rawValue: Environment.secretKey]
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var body: Data? {
        let encoder = JSONEncoder()
        
        switch self {
        case .write(_, let query):
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(query)
        default: return nil
        }
    }
}
