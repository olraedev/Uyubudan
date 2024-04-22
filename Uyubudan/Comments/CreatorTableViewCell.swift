//
//  CommentsTableViewCell.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/21/24.
//

import UIKit
import RxSwift

final class CreatorTableViewCell: UITableViewCell {
    
    var disposeBag = DisposeBag()
    
    private let profileImageView = ProfileImageView(frame: .zero)
    
    private let nicknameLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    private let contentLabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    let deleteButton = {
        let button = UIButton()
        button.setTitle("삭제", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 13)
        button.backgroundColor = .clear
        button.isHidden = true
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        configureHierarchy()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
    
    func configureCell(_ item: Comment) {
        profileImageView.setImage(url: item.creator.profileImage)
        nicknameLabel.text = item.creator.nick
        contentLabel.text = item.content
        if item.creator.userID == UserDefaultsManager.shared.userID {
            deleteButton.isHidden = false
        }
    }
    
    private func configureHierarchy() {
        contentView.addSubViews([profileImageView, nicknameLabel, contentLabel, deleteButton])
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
            make.trailing.equalTo(deleteButton.snp.leading).offset(-16)
            make.height.equalTo(24)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(8)
            make.leading.equalTo(nicknameLabel)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}
