//
//  PostRouter.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/18/24.
//

import Foundation
import Alamofire

enum PostRouter {
    case uploadImage
    case write(WriteQuery: Encodable)
    case readAll(nextCursor: String)
    case readSpecific(postID: String)
    case update(postID: String, UpdateQuery: Encodable)
    case delete(postID: String)
    case readSpecificUser(userID: String, nextCursor: String)
}

extension PostRouter: TargetType {
    var baseURL: String {
        return Environment.baseURL
    }
    
    var version: String {
        return Version.v1.rawValue
    }
    
    var method: HTTPMethod {
        switch self {
        case .uploadImage, .write: .post
        case .readAll, .readSpecific, .readSpecificUser: .get
        case .update: .put
        case .delete: .delete
        }
    }
    
    var path: String {
        switch self {
        case .uploadImage: "/posts/files"
        case .write, .readAll: "/posts"
        case .update(let postID, _), .readSpecific(let postID), .delete(let postID):
            "/posts/\(postID)"
        case .readSpecificUser(let userID, _):
            "/posts/users/\(userID)"
        }
    }
    
    var header: [String : String] {
        switch self {
        case .uploadImage:
            [HTTPHeader.contentType.rawValue: HTTPHeader.multipart.rawValue,
             HTTPHeader.sesacKey.rawValue: Environment.secretKey]
        default:
            [HTTPHeader.contentType.rawValue: HTTPHeader.json.rawValue,
             HTTPHeader.sesacKey.rawValue: Environment.secretKey]
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .readAll(let nextCursor), .readSpecificUser(_, let nextCursor):
            return [URLQueryItem(name: "product_id", value: "uyubudan"),
            URLQueryItem(name: "next", value: nextCursor)]
        default: return nil
        }
    }
    
    var body: Data? {
        let encoder = JSONEncoder()
        
        switch self {
        case .write(let query), .update(_, let query):
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(query)
        default: return nil
        }
    }
}
