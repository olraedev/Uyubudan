//
//  File.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/15/24.
//

import UIKit

final class JoinView: BaseView {
    
    private let emailLabel = {
        let label = UILabel()
        label.text = "이메일"
        label.textColor = .customPrimary
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    let emailTextField = {
        let tf = UITextField()
        tf.placeholder = "예: uyubudan@example.com"
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        return tf
    }()
    
    let validationButton = {
        let button = PrimaryColorButton()
        button.setTitle("중복확인", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.backgroundColor = .customLightGray
        button.isEnabled = false
        return button
    }()
    
    private lazy var emailStackView = {
        let view = UIStackView(arrangedSubviews: [emailTextField, validationButton])
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fill
        return view
    }()
    
    let emailValidationLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let passwordLabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.textColor = .customPrimary
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    let passwordTextField = {
        let tf = UITextField()
        tf.placeholder = "비밀번호를 입력해주세요"
        tf.borderStyle = .roundedRect
        tf.isSecureTextEntry = true
        tf.textContentType = .oneTimeCode
        tf.autocapitalizationType = .none
        return tf
    }()
    
    private let rePasswordLabel = {
        let label = UILabel()
        label.text = "비밀번호 확인"
        label.textColor = .customPrimary
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    let rePasswordTextField = {
        let tf = UITextField()
        tf.placeholder = "비밀번호를 한번 더 입력해주세요"
        tf.borderStyle = .roundedRect
        tf.isSecureTextEntry = true
        tf.textContentType = .oneTimeCode
        tf.autocapitalizationType = .none
        return tf
    }()
    
    let rePasswordValidationLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let nickLabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.textColor = .customPrimary
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    private let nickTextField = {
        let tf = UITextField()
        tf.placeholder = "예: 우유부단"
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        return tf
    }()
    
    lazy var stackView = {
        let view = UIStackView(arrangedSubviews: [emailLabel, emailStackView, emailValidationLabel, passwordLabel, passwordTextField, rePasswordLabel, rePasswordTextField, rePasswordValidationLabel, nickLabel, nickTextField])
        view.axis = .vertical
        view.spacing = 8
        view.setCustomSpacing(16, after: emailValidationLabel)
        view.setCustomSpacing(24, after: passwordTextField)
        view.setCustomSpacing(16, after: rePasswordValidationLabel)
        return view
    }()
    
    let completeButton = {
        let button = PrimaryColorButton()
        button.setTitle("완료", for: .normal)
        return button
    }()
    
    override func configureHierarchy() {
        addSubview(stackView)
        addSubview(completeButton)
    }
    
    override func configureConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        completeButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(50)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        validationButton.snp.makeConstraints { make in
            make.width.equalTo(80)
        }
        
        emailStackView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        emailValidationLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        rePasswordLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
        }
        
        rePasswordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        rePasswordValidationLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
        }
        
        nickLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
        }
        
        nickTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
}
