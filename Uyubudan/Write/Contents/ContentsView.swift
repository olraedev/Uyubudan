//
//  ContentView.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/21/24.
//

import UIKit

final class ContentsView: WriteView {
    private let titlesLabel = {
        let label = UILabel()
        label.text = "제목 (30자 제한)"
        label.textColor = .customPrimary
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    let titleTextField = {
        let view = CustomTextField(placeHolder: "오랜만에 여행가는데 어디가 좋을까요?")
        return view
    }()
    
    private let contentLabel = {
        let label = UILabel()
        label.text = "내용 (1,000자 제한)"
        label.textColor = .customPrimary
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    let contentTextView = {
        let view = UITextView()
        view.layer.borderColor = UIColor.systemGray6.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        view.isScrollEnabled = false
        view.autocapitalizationType = .none
        view.font = .systemFont(ofSize: 18)
        return view
    }()
    
    let placeHolder = {
        let label = UILabel()
        label.text = "포스트 내용"
        label.textColor = .systemGray4
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        addSubViews([titlesLabel, titleTextField, contentLabel, contentTextView, placeHolder])
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        
        titlesLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(24)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(titlesLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(24)
        }
        
        contentTextView.setContentHuggingPriority(.init(750), for: .vertical)
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.greaterThanOrEqualTo(50)
            make.bottom.lessThanOrEqualTo(completeButton.snp.top).offset(-16)
        }
        
        placeHolder.snp.makeConstraints { make in
            make.top.equalTo(contentTextView.snp.top).offset(8)
            make.leading.equalTo(contentTextView.snp.leading).offset(8)
        }
    }
    
    override func configureViews() {
        titleLabel.text = "제목과 내용을\n입력해주세요"
    }
}
