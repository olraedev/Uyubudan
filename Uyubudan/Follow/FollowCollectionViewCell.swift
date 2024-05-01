//
//  FollowCollectionViewCell.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/25/24.
//

import UIKit

final class FollowCollectionViewCell: BaseCollectionViewCell {
    
    private let profileImageView = ProfileImageView(frame: .zero)
    
    private let nicknameLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    let followButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 13)
        return button
    }()
    
    func configureCell(_ item: FollowInfo, followingList: [String: Bool]) {        
        profileImageView.setImage(url: item.profileImage)
        nicknameLabel.text = item.nickname
        followButton.isHidden = item.userID == UserDefaultsManager.userID ? true : false
        
        guard let state = followingList[item.userID] else { return }
        
        if state {
            followButton.setTitle("팔로잉", for: .normal)
            followButton.setTitleColor(.darkGray, for: .normal)
            followButton.backgroundColor = .customLightGray
        }
        else {
            followButton.setTitle("팔로우", for: .normal)
            followButton.setTitleColor(.darkGray, for: .normal)
            followButton.backgroundColor = .customTertiary
        }
    }
    
    override func configureHierarchy() {
        contentView.addSubViews([profileImageView, nicknameLabel, followButton])
    }
    
    override func configureConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(32)
            make.size.equalTo(40)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.leading.equalTo(profileImageView.snp.trailing).offset(16)
            make.trailing.equalTo(followButton.snp.leading).offset(-16)
            make.height.equalTo(24)
        }
        
        followButton.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.trailing.equalToSuperview().offset(-32)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
    }
}
