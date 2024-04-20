//
//  UserRouter.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/16/24.
//

import Foundation
import Alamofire

enum UserRouter {
    case join(JoinQuery: Encodable)
    case emailValidation(EmailValidationQuery: Encodable)
    case login(LoginQuery: Encodable)
    case authRefresh
    case withdraw
}

extension UserRouter: TargetType {
    var baseURL: String {
        return Environment.baseURL
    }
    
    var version: String {
        return Version.v1.rawValue
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .join, .emailValidation, .login: .post
        case .authRefresh, .withdraw: .get
        }
    }
    
    var path: String {
        switch self {
        case .join: "/users/join"
        case .emailValidation: "/validation/email"
        case .login: "/users/login"
        case .authRefresh: "/auth/refresh"
        case .withdraw: "/users/withdraw"
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
        case .join(let query), .emailValidation(let query), .login(let query):
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(query)
        default: return nil
        }
    }
}
