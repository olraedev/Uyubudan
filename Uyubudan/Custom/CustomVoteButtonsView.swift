//
//  CustomVoteButtonsView.swift
//  Uyubudan
//
//  Created by SangRae Kim on 5/2/24.
//

import UIKit

final class CustomVoteButtonsView: BaseView {
    
    let leftButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .customSecondary
        button.clipsToBounds = true
        return button
    }()
    
    private let vsLabel = {
        let label = UILabel()
        label.text = "VS"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .customPrimary
        return label
    }()
    
    let rightButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .customTertiary
        button.clipsToBounds = true
        return button
    }()
    
    func configureButtonsOpacity(_ state: LikeState) {
        leftButton.layer.opacity = 0.5
        rightButton.layer.opacity = 0.5
        
        switch state {
        case .left:
            leftButton.layer.opacity = 1.0
            leftButton.layer.borderColor = UIColor.customSecondary.cgColor
            leftButton.layer.borderWidth = 3
        case .right:
            rightButton.layer.opacity = 1.0
            rightButton.layer.borderColor = UIColor.customTertiary.cgColor
            rightButton.layer.borderWidth = 3
        case .none:
            leftButton.layer.borderWidth = 0
            rightButton.layer.borderWidth = 0
        }
    }
    
    func configureButtonsTitle(_ item: PostData) {
        let imageCount = item.files.count
        
        leftButton.setBackgroundImage(nil, for: .normal)
        rightButton.setBackgroundImage(nil, for: .normal)
        leftButton.setTitle(item.content1, for: .normal)
        rightButton.setTitle(item.content2, for: .normal)
        
        if imageCount == 2 {
            leftButton.setImageWithURL(item.files[0])
            rightButton.setImageWithURL(item.files[1])
        }
    }
    
    override func configureHierarchy() {
        addSubViews([leftButton, vsLabel, rightButton])
    }
    
    override func configureConstraints() {
        leftButton.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.leading.equalToSuperview().offset(40)
            make.verticalEdges.equalToSuperview()
        }
        
        vsLabel.snp.makeConstraints { make in
            make.centerY.equalTo(leftButton)
            make.centerX.equalToSuperview()
        }
        
        rightButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-40)
            make.size.equalTo(100)
            make.verticalEdges.equalToSuperview()
        }
    }
}
