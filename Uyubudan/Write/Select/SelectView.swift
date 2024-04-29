//
//  SelectView.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/21/24.
//

import UIKit

final class SelectView: WriteView {
    
    private let leftTitle = {
        let label = UILabel()
        label.text = "고민-1"
        label.textColor = .customPrimary
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    let leftTextField = {
        let view = CustomTextField()
        view.placeholder = "국내"
        return view
    }()
    
    private let rightTitle = {
        let label = UILabel()
        label.text = "고민-2"
        label.textColor = .customPrimary
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    let rightTextField = {
        let view = CustomTextField()
        view.placeholder = "해외"
        return view
    }()
    
    private let imageTitle = {
        let label = UILabel()
        label.text = "고민 사진 올리기! (최대 2장)"
        label.textColor = .customPrimary
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    let leftImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.systemGray6.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    let rightImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.systemGray6.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    let uploadButton = {
        let button = PrimaryColorButton()
        button.setTitle("이미지 업로드", for: .normal)
        return button
    }()
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        addSubViews([
            leftTitle, leftTextField, rightTitle, rightTextField,
            imageTitle, leftImageView, rightImageView, uploadButton
        ])
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        
        leftTitle.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.centerX.equalTo(leftImageView)
            make.height.equalTo(24)
        }
        
        rightTitle.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.centerX.equalTo(rightImageView)
            make.height.equalTo(24)
        }
        
        leftImageView.snp.makeConstraints { make in
            make.top.equalTo(leftTitle.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(snp.centerX).offset(-16)
            make.height.equalTo(leftImageView.snp.width).multipliedBy(1)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.top.equalTo(rightTitle.snp.bottom).offset(8)
            make.leading.equalTo(snp.centerX).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(rightImageView.snp.width).multipliedBy(1)
        }
        
        leftTextField.snp.makeConstraints { make in
            make.top.equalTo(leftImageView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(leftImageView)
            make.height.equalTo(50)
        }
        
        rightTextField.snp.makeConstraints { make in
            make.top.equalTo(rightImageView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(rightImageView)
            make.height.equalTo(50)
        }
        
        uploadButton.snp.makeConstraints { make in
            make.top.equalTo(leftTextField.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
    
    override func configureViews() {
        titleLabel.text = "고민 내용을\n입력해주세요"
        completeButton.setTitle("작성 완료", for: .normal)
    }
}
