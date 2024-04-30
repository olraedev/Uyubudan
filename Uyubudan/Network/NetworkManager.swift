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
                    .validate(statusCode: 200..<300)
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
    
    static func fetchPostToServer(nextCursor: String) -> Single<Result<ReadAllModel, HTTPError>> {
        return Single<Result<ReadAllModel, HTTPError>>.create { single in
            do {
                var urlRequest = try PostRouter.readAll.asURLRequest()
                urlRequest.url?.append(queryItems: [URLQueryItem(name: "next", value: nextCursor)])
                
                AF.request(urlRequest, interceptor: NetworkInterceptor())
                    .validate(statusCode: 200..<300)
                    .responseDecodable(of: ReadAllModel.self) { response in
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
    
    static func uploadImageToServer(datas: [Data]) -> Single<Result<UploadImageModel, HTTPError>> {
        return Single<Result<UploadImageModel, HTTPError>>.create { single in
            do {
                let urlRequest = try PostRouter.uploadImage.asURLRequest()
                
                AF.upload(multipartFormData: { multipartFormData in
                    for data in datas {
                        multipartFormData.append(data, withName: "files", fileName: "uyubudan.png", mimeType: "image/png")
                    }
                }, with: urlRequest, interceptor: NetworkInterceptor())
                .responseDecodable(of: UploadImageModel.self) { response in
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
    
    static func editProfileWithImage<M: Decodable, T: TargetType>(model: M.Type, router: T, nick: String, data: Data) -> Single<Result<M, HTTPError>> {
        return Single<Result<M, HTTPError>>.create { single in
            do {
                let urlRequest = try router.asURLRequest()
                
                AF.upload(multipartFormData: { multipartFormData in
                    multipartFormData.append(nick.data(using: .utf8)!, withName: "nick")
                    multipartFormData.append(data, withName: "profile", fileName: "profileImage.png", mimeType: "image/png")
                }, with: urlRequest, interceptor: NetworkInterceptor())
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
    
    static func fetchToServerNoModel<T: TargetType>(router: T) -> Single<Result<Int, HTTPError>> {
        return Single<Result<Int, HTTPError>>.create { single in
            do {
                let urlRequest = try router.asURLRequest()
                
                AF.request(urlRequest, interceptor: NetworkInterceptor())
                    .validate(statusCode: 200..<300)
                    .responseString(completionHandler: { response in
                        guard let statusCode = response.response?.statusCode else {
                            single(.success(.failure(.serverError)))
                            return
                        }
                        
                        if statusCode == 200 {
                            single(.success(.success(statusCode)))
                        }
                        
                        if let code = HTTPError(rawValue: statusCode) {
                            single(.success(.failure(code)))
                        }
                    })
            } catch {
                single(.success(.failure(.serverError)))
            }
            
            return Disposables.create()
        }
    }
    
    static func fetchRefreshTokenToServer(completionHandler: @escaping (Result<AuthRefreshModel, HTTPError>) -> Void) {
        do {
            var urlRequest = try UserRouter.authRefresh.asURLRequest()
            
            urlRequest.setValue(UserDefaultsManager.shared.accessToken, forHTTPHeaderField: HTTPHeader.authorization.rawValue)
            urlRequest.setValue(UserDefaultsManager.shared.refreshToken, forHTTPHeaderField: HTTPHeader.refresh.rawValue)
            
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
