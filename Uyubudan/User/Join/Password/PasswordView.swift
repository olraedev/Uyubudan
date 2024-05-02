//
//  PasswordView.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/16/24.
//

import UIKit

final class PasswordView: JoinView {
    
    private let passwordLabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.textColor = .customPrimary
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    let passwordTextField = {
        let tf = CustomTextField(placeHolder: "비밀번호를 입력해주세요")
        tf.isSecureTextEntry = true
        tf.textContentType = .oneTimeCode
        return tf
    }()
    
    func designViewWithPasswordValidation(state: Bool) {
        let validationText = state ? "사용 가능한 비밀번호입니다." : "4글자 이상 15글자 미만으로 입력해주세요."
        
        validationLabel.text = validationText
        validationLabel.textColor = state.textColor
        
        completeButton.isEnabled = state
        completeButton.backgroundColor = state.buttonColor
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        addSubview(passwordLabel)
        addSubview(passwordTextField)
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(24)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(8)
            make.height.equalTo(50)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        validationLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(24)
        }
    }
    
    override func configureViews() {
        titleLabel.text = "비밀번호를\n입력해주세요"
    }
}
