//
//  Extension+UIImageView.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/29/24.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(url: String) {
        let url = URL(string: Environment.baseURL + "/v1/\(url)")
        let imageDownloadRequest = AnyModifier { request in
            var request = request
            request.setValue(Environment.secretKey, forHTTPHeaderField: HTTPHeader.sesacKey.rawValue)
            request.setValue(UserDefaultsManager.accessToken,  forHTTPHeaderField: HTTPHeader.authorization.rawValue)
            return request
        }
        
        kf.setImage(with: url,options: [.requestModifier(imageDownloadRequest)])
    }
}
