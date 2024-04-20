//
//  ProfileImageView.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/14/24.
//

import UIKit
import Kingfisher

final class ProfileImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tintColor = .customLightGray
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.borderWidth = 1
        contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.masksToBounds = true
        clipsToBounds = true
        layer.cornerRadius = frame.height / 2
    }
    
    func setImage(url: String) {
        let url = URL(string: Environment.baseURL + "/v1/\(url)")
        let imageDownloadRequest = AnyModifier { request in
            var request = request
            request.setValue(Environment.secretKey, forHTTPHeaderField: HTTPHeader.sesacKey.rawValue)
            request.setValue(UserDefaultsManager.shared.accessToken,  forHTTPHeaderField: HTTPHeader.authorization.rawValue)
            return request
        }
        kf.setImage(with: url, options: [.requestModifier(imageDownloadRequest)])
    }
}
