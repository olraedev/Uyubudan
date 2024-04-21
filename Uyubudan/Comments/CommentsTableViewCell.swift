//
//  CommentsTableViewCell.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/21/24.
//

import UIKit

final class CommentsTableViewCell: UITableViewCell {
    
    private let profileImageView = ProfileImageView(frame: .zero)
    
    private let nicknameLabel = {
        let label = UILabel()
        label.text = "고래밥"
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    private let contentLabel = {
        let label = UILabel()
        label.text = "aweobfowbfobefobqbfoqbofbq"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ item: Comment) {
        profileImageView.setImage(url: item.creator.profileImage)
        nicknameLabel.text = item.creator.nick
        contentLabel.text = item.content
    }
    
    private func configureHierarchy() {
        contentView.addSubViews([profileImageView, nicknameLabel, contentLabel])
    }
    
    private func configureConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(40)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top)
            make.leading.equalTo(profileImageView.snp.trailing).offset(16)
            make.height.equalTo(24)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(8)
            make.leading.equalTo(nicknameLabel)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}
