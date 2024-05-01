//
//  NetworkConnectedFailedViewController.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/30/24.
//

import UIKit
import SnapKit

final class NetworkConnectionFailView: BaseView {
    
    private let imageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "wifi.slash")
        view.tintColor = .customPrimary
        return view
    }()
    
    private let infoLabel = {
        let label = UILabel()
        label.text = "네트워크 연결을 확인해주세요"
        label.font = .boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    override func configureHierarchy() {
        addSubview(imageView)
        addSubview(infoLabel)
    }
    
    override func configureConstraints() {
        imageView.snp.makeConstraints { make in
            make.bottom.equalTo(snp.centerY).offset(-24)
            make.centerX.equalToSuperview()
            make.size.equalTo(150)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.centerY).offset(24)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    override func configureViews() {
        backgroundColor = .white
        alpha = 0.8
    }
}
