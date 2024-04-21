//
//  CategoryCollectionViewCell.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/21/24.
//

import UIKit

final class CategoryCollectionViewCell: BaseCollectionViewCell {
    
    let button = {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .systemGray5
        configuration.cornerStyle = .capsule
        let view = UIButton(configuration: configuration)
        view.setTitleColor(.black, for: .normal)
        return view
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(button)
    }
    
    override func configureConstraints() {
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureCell(title: String, nowCategory: String) {
        button.setTitle(title, for: .normal)
        
        if title == nowCategory {
            button.configuration?.baseBackgroundColor = .customPrimary
            button.setTitleColor(.white, for: .normal)
        } else {
            button.configuration?.baseBackgroundColor = .systemGray5
            button.setTitleColor(.black, for: .normal)
        }
    }
}
