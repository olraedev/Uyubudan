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
                var urlRequest = try router.asURLRequest()
                urlRequest.addValue(UserDefaultsManager.shared.accessToken, forHTTPHeaderField: HTTPHeader.authorization.rawValue)
                
                AF.request(urlRequest)
                    .validate(statusCode: 200..<300)
                    .responseDecodable(of: M.self) { response in
                        switch response.result {
                        case .success(let model):
                            dump(model)
                            single(.success(.success(model)))
                        case .failure(_):
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
}
