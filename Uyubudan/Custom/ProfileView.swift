//
//  ProfileView.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/19/24.
//

import UIKit

final class ProfileView: BaseView {
    
    private let profileImageView = {
        let view = ProfileImageView(frame: .zero)
        view.image = UIImage(systemName: "person.fill")
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
    
    let detailProfileButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .darkGray
        button.backgroundColor = .customLightGray
        return button
    }()
    
    override func configureHierarchy() {
        addSubview(profileImageView)
        addSubview(creatorNickLabel)
        addSubview(creatorLabel)
        addSubview(detailProfileButton)
    }
    
    override func configureConstraints() {
        self.snp.makeConstraints { make in
            make.height.equalTo(64)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
            make.size.equalTo(40)
        }
        
        creatorNickLabel.snp.makeConstraints { make in
            make.bottom.equalTo(snp.centerY)
            make.leading.equalTo(profileImageView.snp.trailing).offset(16)
            make.height.equalTo(16)
        }
        
        creatorLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.centerY)
            make.leading.equalTo(creatorNickLabel)
            make.height.equalTo(16)
        }
        
        detailProfileButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-24)
            make.size.equalTo(30)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        detailProfileButton.layoutIfNeeded()
        detailProfileButton.layer.cornerRadius = detailProfileButton.frame.width / 2
    }
}
