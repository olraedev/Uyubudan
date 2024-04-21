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
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        addSubViews([leftTitle, leftTextField, rightTitle, rightTextField])
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        
        leftTitle.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(24)
        }
        
        leftTextField.snp.makeConstraints { make in
            make.top.equalTo(leftTitle.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        rightTitle.snp.makeConstraints { make in
            make.top.equalTo(leftTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(24)
        }
        
        rightTextField.snp.makeConstraints { make in
            make.top.equalTo(rightTitle.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    override func configureViews() {
        titleLabel.text = "고민 내용을\n입력해주세요"
        completeButton.setTitle("작성 완료", for: .normal)
    }
}
