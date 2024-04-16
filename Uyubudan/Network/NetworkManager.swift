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
    
    static func fetchToServer<Q: Encodable, M: Decodable, T: TargetType>(query: Q, model: M.Type, router: T) -> Single<Result<M, HTTPError>> {
        return Single<Result<M, HTTPError>>.create { single in
            do {
                let urlRequest = try router.asURLRequest()
                                
                AF.request(urlRequest)
                    .validate(statusCode: 200..<300)
                    .responseDecodable(of: M.self) { response in
                        switch response.result {
                        case .success(let loginModel):
                            single(.success(.success(loginModel)))
                        case .failure(let error):
                            guard let statusCode = response.response?.statusCode else {
                                single(.success(.failure(.serverError)))
                                return
                            }
                            
                            if let code = HTTPError(rawValue: statusCode) {
                                single(.success(.failure(code)))
                            }
                        }
                    }
            } catch {
                single(.failure(error))
            }
            
            return Disposables.create()
        }
    }
}
