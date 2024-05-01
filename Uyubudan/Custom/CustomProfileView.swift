//
//  ProfileView.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/19/24.
//

import UIKit

final class CustomProfileView: BaseView {
    
    let profileImageView = {
        let view = ProfileImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let creatorNickLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 13)
        label.textColor = .black
        return label
    }()
    
    private let creatorLabel = {
        let label = UILabel()
        label.text = "투표게시자"
        label.font = .systemFont(ofSize: 11)
        label.textColor = .systemGray3
        return label
    }()
    
    let followButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 13)
        return button
    }()
    
    override func configureHierarchy() {
        addSubview(profileImageView)
        addSubview(creatorNickLabel)
        addSubview(creatorLabel)
        addSubview(followButton)
    }
    
    override func configureConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
            make.size.equalTo(45)
        }
        
        creatorNickLabel.snp.makeConstraints { make in
            make.bottom.equalTo(profileImageView.snp.centerY)
            make.leading.equalTo(profileImageView.snp.trailing).offset(16)
            make.height.equalTo(16)
        }
        
        creatorLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.centerY)
            make.leading.equalTo(creatorNickLabel)
            make.height.equalTo(16)
        }
        
        followButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-24)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
    }
    
}

