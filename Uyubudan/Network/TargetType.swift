//
//  TargetType.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/16/24.
//

import Foundation
import Alamofire

protocol TargetType: URLRequestConvertible {
    var baseURL: String { get }
    var version: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var header: [String: String] { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
}

extension TargetType {
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var urlRequest: URLRequest
        
        if let queryItems {
            urlRequest = try URLRequest(url: url.appendingPathComponent(version).appendingPathComponent(path).appending(queryItems: queryItems), method: method)
        } else {
            urlRequest = try URLRequest(url: url.appendingPathComponent(version).appendingPathComponent(path), method: method)
        }
        
        urlRequest.allHTTPHeaderFields = header
        urlRequest.httpBody = body
        
        return urlRequest
    }
}
