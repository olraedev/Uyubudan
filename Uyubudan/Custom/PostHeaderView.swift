//
//  PostHeaderView.swift
//  Uyubudan
//
//  Created by SangRae Kim on 5/2/24.
//

import UIKit

final class PostHeaderView: BaseView {
    
    private let categoryLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
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
    
    private let emptyView = {
        let view = UIView()
        view.backgroundColor = .customPrimary
        return view
    }()
    
    private let titleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    func configureViewWithPostData(_ item: PostData, userID: String) {
        categoryLabel.text = item.content3
        deleteButton.isHidden = userID == item.creator.userID ? false : true
        titleLabel.text = item.title
    }
    
    override func configureHierarchy() {
        addSubViews([categoryLabel, deleteButton, emptyView, titleLabel])
    }
    
    override func configureConstraints() {
        categoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(16)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.top)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(13)
            make.width.equalTo(3)
            make.height.equalTo(24)
            make.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(emptyView.snp.verticalEdges)
            make.leading.equalTo(emptyView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-24)
        }
    }
}
