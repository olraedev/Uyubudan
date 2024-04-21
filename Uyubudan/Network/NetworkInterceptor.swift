//
//  NetworkInterceptor.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/20/24.
//

import UIKit
import Alamofire

class NetworkInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        
        var urlRequest = urlRequest
        
        urlRequest.setValue(UserDefaultsManager.shared.accessToken, forHTTPHeaderField: HTTPHeader.authorization.rawValue)
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        guard request.retryCount < 1,
              let response = request.task?.response as? HTTPURLResponse,
              response.statusCode == 419 else {
                  print("Retry 못함요")
                  completion(.doNotRetry)
                  return
              }
        
        // status 419 받는 경우
        if response.statusCode == 419 {
            NetworkManager.fetchRefreshTokenToServer()
            completion(.retry)
        }
        else {
            DispatchQueue.main.async {
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                let nav = LoginViewController()
                sceneDelegate?.window?.rootViewController = nav
                sceneDelegate?.window?.makeKeyAndVisible()
            }
            completion(.doNotRetry)
        }
    }
}
