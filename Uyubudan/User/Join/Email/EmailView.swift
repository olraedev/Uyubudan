//
//  EmailView.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/15/24.
//

import UIKit

final class EmailView: JoinView {
    
    private let emailLabel = {
        let label = UILabel()
        label.text = "이메일"
        label.textColor = .customPrimary
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    let emailTextField = {
        let tf = CustomTextField(placeHolder: "uyubudan@example.com")
        return tf
    }()
    
    let validationButton = {
        let button = PrimaryColorButton()
        button.setTitle("중복확인", for: .normal)
        button.backgroundColor = .lightGray
        button.isEnabled = false
        return button
    }()
    
    func designViewWithEmailRegex(state: Bool) {
        let text = state ? "중복확인을 해주세요." : "이메일 주소를 정확하게 입력해주세요."
        
        validationButton.isEnabled = state
        validationButton.backgroundColor = state.buttonColor
        
        validationLabel.textColor = state.textColor
        validationLabel.text = text
    }
    
    func designViewWithEmailValidation(state: Bool) {
        completeButton.isEnabled = state
        completeButton.backgroundColor = state.buttonColor
        
        validationLabel.textColor = state.textColor
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        addSubview(emailLabel)
        addSubview(emailTextField)
        addSubview(validationButton)
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(24)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(validationButton.snp.leading).offset(-8)
        }
        
        validationButton.snp.makeConstraints { make in
            make.verticalEdges.equalTo(emailTextField)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
            make.width.equalTo(80)
        }
        
        validationLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(24)
        }
    }
    
    override func configureViews() {
        titleLabel.text = "이메일을\n입력해주세요"
    }
}
