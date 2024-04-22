//
//  LoginView.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/15/24.
//

import UIKit

final class LoginView: BaseView {
    
    private let logo = {
        let label = UILabel()
        label.text = "우유부단"
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let loginView = {
        let view = UIView()
        return view
    }()
    
    private let emailLabel = {
        let label = UILabel()
        label.text = "이메일"
        label.textColor = .customPrimary
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    let emailTextField = {
        let tf = CustomTextField()
        tf.placeholder = "이메일을 입력해주세요"
        return tf
    }()
    
    private let passwordLabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.textColor = .customPrimary
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    let passwordTextField = {
        let tf = CustomTextField()
        tf.placeholder = "비밀번호를 입력해주세요"
        tf.isSecureTextEntry = true
        tf.textContentType = .oneTimeCode
        return tf
    }()
    
    let loginButton = {
        let button = PrimaryColorButton()
        button.setTitle("로그인", for: .normal)
        return button
    }()
    
    let joinButton = {
        let button = UIButton()
        button.setTitle("아직 회원이 아니세요?", for: .normal)
        button.setTitleColor(.customPrimary, for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = .boldSystemFont(ofSize: 13)
        return button
    }()
    
    override func configureHierarchy() {
        addSubview(logo)
        addSubview(loginView)
        loginView.addSubview(emailLabel)
        loginView.addSubview(emailTextField)
        loginView.addSubview(passwordLabel)
        loginView.addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(joinButton)
    }
    
    override func configureConstraints() {
        logo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide).offset(56)
        }
        
        loginView.snp.makeConstraints { make in
            make.top.equalTo(logo.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(16)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(16)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-24)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(loginView.snp.bottom).offset(16)
            make.height.equalTo(50)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        joinButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(30)
        }
    }
}
