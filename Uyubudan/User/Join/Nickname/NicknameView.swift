//
//  NicknameView.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/16/24.
//

import UIKit

final class NicknameView: JoinView {
    
    private let nickLabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.textColor = .customPrimary
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    private let nickTextField = {
        let tf = CustomTextField()
        tf.placeholder = "결정마스터"
        return tf
    }()
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        addSubview(nickLabel)
        addSubview(nickTextField)
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        
        nickLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(24)
        }
        
        nickTextField.snp.makeConstraints { make in
            make.top.equalTo(nickLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        validationLabel.snp.makeConstraints { make in
            make.top.equalTo(nickTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(24)
        }
    }
    
    override func configureViews() {
        titleLabel.text = "닉네임을\n입력해주세요"
        completeButton.setTitle("회원가입 완료", for: .normal)
    }
}
