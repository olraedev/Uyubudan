//
//  HTTPError.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/16/24.
//

import Foundation

enum HTTPError: Int, Error {
    case checkAccount = 401
    case wrongSesacKey = 420
    case overRequest = 429
    case invalidURL = 444
    case serverError = 500
}
