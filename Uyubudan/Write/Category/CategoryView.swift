//
//  CategoryView.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/21/24.
//

import UIKit

final class CategoryView: WriteView {
    
    private let categoryLabel = {
        let label = UILabel()
        label.text = "카테고리"
        label.textColor = .customPrimary
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    let categoryPickerView = {
        let view = UIPickerView()
        view.tintColor = .customPrimary
        return view
    }()
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        addSubview(categoryLabel)
        addSubview(categoryPickerView)
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(24)
        }
        
        categoryPickerView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    override func configureViews() {
        titleLabel.text = "카테고리를\n선택해주세요"
    }
}
