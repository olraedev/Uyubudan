//
//  PostRouter.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/18/24.
//

import Foundation
import Alamofire

enum PostRouter {
    case uploadImage(UploadImageQuery: Encodable)
    case write(WriteQuery: Encodable)
    case readAll
    case readSpecific(id: String)
    case update(id: String, UpdateQuery: Encodable)
    case delete(id: String)
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
        case .readAll, .readSpecific: .get
        case .update: .put
        case .delete: .delete
        }
    }
    
    var path: String {
        switch self {
        case .uploadImage: "/posts/files"
        case .write, .readAll: "/posts"
        case .update(let id, _):
            "/posts/\(id)"
        case .readSpecific(let id), .delete(let id):
            "/posts/\(id)"
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
        case .readAll: return [URLQueryItem(name: "product_id", value: "uyubudan")]
        default: return nil
        }
    }
    
    var body: Data? {
        let encoder = JSONEncoder()
        
        switch self {
        case .uploadImage(let query), .write(let query):
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(query)
        case .update(_, let query):
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(query)
        default: return nil
        }
    }
}
