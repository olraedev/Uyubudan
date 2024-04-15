//
//  File.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/15/24.
//

import UIKit

class JoinView: BaseView {
    
    let titleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let completeButton = {
        let button = PrimaryColorButton()
        button.setTitle("다음", for: .normal)
        button.isEnabled = false
        button.backgroundColor = .lightGray
        return button
    }()
    
    let validationLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    override func configureHierarchy() {
        addSubview(titleLabel)
        addSubview(completeButton)
        addSubview(validationLabel)
    }
    
    override func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(56)
            make.leading.equalTo(24)
        }
        
        completeButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-24)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(50)
        }
    }
}
