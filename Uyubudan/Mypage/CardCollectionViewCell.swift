//
//  CardCollectionViewCell.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/22/24.
//

import UIKit

final class CardCollectionViewCell: BaseCollectionViewCell {
    
    let title = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    override func configureHierarchy() {
        contentView.addSubViews([title])
    }
    
    override func configureConstraints() {
        title.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    override func configureViews() {
        layer.masksToBounds = true
        layer.cornerRadius = 10
    }
}
