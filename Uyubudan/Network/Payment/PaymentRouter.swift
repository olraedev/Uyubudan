//
//  PaymentRouter.swift
//  Uyubudan
//
//  Created by SangRae Kim on 5/2/24.
//

import Foundation
import Alamofire

enum PaymentRouter {
    case validation(PaymentValidationQuery)
    case history
}

extension PaymentRouter: TargetType {
    var baseURL: String {
        Environment.baseURL
    }
    
    var version: String {
        Version.v1.rawValue
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .validation: .post
        case .history: .get
        }
    }
    
    var path: String {
        switch self {
        case .validation: "/payments/validation"
        case .history: "/payments/me"
        }
    }
    
    var header: [String : String] {
        return [
            HTTPHeader.sesacKey.rawValue: Environment.secretKey,
            HTTPHeader.contentType.rawValue: HTTPHeader.json.rawValue
        ]
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var body: Data? {
        let encoder = JSONEncoder()
        
        switch self {
        case .validation(let query):
            encoder.keyEncodingStrategy = .useDefaultKeys
            return try? encoder.encode(query)
        default: return nil
        }
    }
}
