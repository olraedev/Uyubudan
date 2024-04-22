//
//  ProfileRouter.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/22/24.
//

import Foundation
import Alamofire

enum ProfileRouter {
    case read
    case update(ProfileRouter: Encodable)
    case readSpecific(userID: String)
}

extension ProfileRouter: TargetType {
    var baseURL: String {
        return Environment.baseURL
    }
    
    var version: String {
        return Version.v1.rawValue
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .read, .readSpecific: .get
        case .update: .put
        }
    }
    
    var path: String {
        switch self {
        case .read, .update: "/users/me/profile"
        case .readSpecific(let userID): "/users/\(userID)/profile"
        }
    }
    
    var header: [String : String] {
        switch self {
        case .read, .readSpecific(_): 
            [HTTPHeader.contentType.rawValue: HTTPHeader.json.rawValue,
            HTTPHeader.sesacKey.rawValue: Environment.secretKey]
        case .update: 
            [HTTPHeader.contentType.rawValue: HTTPHeader.multipart.rawValue,
            HTTPHeader.sesacKey.rawValue: Environment.secretKey]
        }
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var body: Data? {
        let encoder = JSONEncoder()
        
        switch self {
        case .update(let query):
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(query)
        default: return nil
        }
    }
}
