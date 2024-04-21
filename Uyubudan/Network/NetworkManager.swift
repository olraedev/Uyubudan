//
//  NetworkManager.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/16/24.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

final class NetworkManager {
    
    static func fetchToServer<M: Decodable, T: TargetType>(model: M.Type, router: T) -> Single<Result<M, HTTPError>> {
        return Single<Result<M, HTTPError>>.create { single in
            do {
                let urlRequest = try router.asURLRequest()
                
                AF.request(urlRequest, interceptor: NetworkInterceptor())
                    // .validate(statusCode: 200..<300)
                    .responseDecodable(of: M.self) { response in
                        switch response.result {
                        case .success(let model):
                            print("success")
                            single(.success(.success(model)))
                        case .failure(let error):
                            print("failure: \(error)")
                            guard let statusCode = response.response?.statusCode else {
                                single(.success(.failure(.serverError)))
                                return
                            }
                            
                            print(statusCode)
                            if let code = HTTPError(rawValue: statusCode) {
                                single(.success(.failure(code)))
                            }
                        }
                    }
            } catch {
                single(.success(.failure(.serverError)))
            }
            
            return Disposables.create()
        }
    }
    
    static func fetchRefreshTokenToServer(completionHandler: @escaping (Result<AuthRefreshModel, HTTPError>) -> Void) {
        do {
            var urlRequest = try UserRouter.authRefresh.asURLRequest()
            
            urlRequest.addValue(UserDefaultsManager.shared.accessToken, forHTTPHeaderField: HTTPHeader.authorization.rawValue)
            urlRequest.addValue(UserDefaultsManager.shared.refreshToken, forHTTPHeaderField: HTTPHeader.refresh.rawValue)
            
            AF.request(urlRequest)
                .responseDecodable(of: AuthRefreshModel.self) { response in
                    switch response.result {
                    case .success(let model):
                        completionHandler(.success(model))
                    case .failure(_):
                        guard let statusCode = response.response?.statusCode else {
                            completionHandler(.failure(.serverError))
                            return
                        }
                        if let code = HTTPError(rawValue: statusCode) {
                            completionHandler(.failure(code))
                        }
                    }
                }
        } catch {
            
        }
    }
}
