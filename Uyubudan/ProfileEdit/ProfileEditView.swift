//
//  ProfileEditView.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/23/24.
//

import UIKit

final class ProfileEditView: BaseView {
    
    let profileImageView = ProfileImageView(frame: .zero)
    
    let imageEditButton = {
        var configuration = UIButton.Configuration.tinted()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 11, weight: .light)
        configuration.image = UIImage(systemName: "camera.fill", withConfiguration: imageConfig)
        configuration.baseBackgroundColor = .customPrimary
        configuration.baseForegroundColor = .white
        configuration.buttonSize = .mini
        let button = UIButton(configuration: configuration)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = .customPrimary
        return button
    }()
    
    private let nickLabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.textColor = .customPrimary
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    let nickTextField = {
        let tf = CustomTextField(placeHolder: "닉네임을 입력해주세요")
        return tf
    }()
    
    let validationLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    let completeButton = {
        let button = PrimaryColorButton()
        button.setTitle("완료", for: .normal)
        return button
    }()
    
    func configureView(_ item: ProfileModel) {
        profileImageView.setImage(url: item.profileImage)
        nickTextField.text = item.nickname
    }
    
    let popButtonItem = {
        let item = UIBarButtonItem(image: UIImage(systemName: "chevron.left"))
        item.tintColor = .black
        return item
    }()
    
    override func configureHierarchy() {
        addSubViews([
            profileImageView, imageEditButton, nickLabel, nickTextField,
            validationLabel, completeButton
        ])
    }
    
    override func configureConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
            make.top.equalTo(safeAreaLayoutGuide).offset(24)
        }
        
        imageEditButton.snp.makeConstraints { make in
            make.trailing.equalTo(profileImageView.snp.trailing).offset(-3)
            make.bottom.equalTo(profileImageView.snp.bottom).offset(-3)
            make.size.equalTo(30)
        }
        
        nickLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(24)
        }
        
        nickTextField.snp.makeConstraints { make in
            make.top.equalTo(nickLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        validationLabel.snp.makeConstraints { make in
            make.top.equalTo(nickTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(24)
        }
        
        completeButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-24)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(50)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageEditButton.layer.cornerRadius = imageEditButton.frame.width / 2
    }
}
