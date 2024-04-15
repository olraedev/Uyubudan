//
//  OnboardingView.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/15/24.
//

import UIKit

final class OnboardingView: BaseView {
    
    private let label = {
        let label = UILabel()
        label.text = "우 유 부 단"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let loginButton = {
        let button = UIButton()
        button.backgroundColor = .customPrimary
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let joinButton = {
        let button = UIButton()
        button.setTitle("아직 회원이 아니신가요?", for: .normal)
        button.setTitleColor(.customPrimary, for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = .systemFont(ofSize: 15)
        return button
    }()
    
    override func configureHierarchy() {
        addSubview(label)
        addSubview(loginButton)
        addSubview(joinButton)
    }
    
    override func configureConstraints() {
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(40)
            make.bottom.equalTo(joinButton.snp.top).offset(-8)
        }
        
        joinButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(40)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-32)
        }
    }
}
