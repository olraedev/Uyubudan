//
//  WriteView.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/20/24.
//

import UIKit

class WriteView: BaseView {
    
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
    
    override func configureHierarchy() {
        addSubview(titleLabel)
        addSubview(completeButton)
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
