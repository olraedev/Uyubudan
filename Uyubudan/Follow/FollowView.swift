//
//  FollowView.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/25/24.
//

import UIKit

final class FollowView: BaseView {
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.register(FollowCollectionViewCell.self, forCellWithReuseIdentifier: FollowCollectionViewCell.identifier)
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(collectionView)
    }
    
    override func configureConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            var config = UICollectionLayoutListConfiguration(appearance: .plain)
            config.showsSeparators = true
            
            let section = NSCollectionLayoutSection.list(
                using: config,
                layoutEnvironment: layoutEnvironment
            )
            section.interGroupSpacing = 8
            section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)
            
            return section
        }
        
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
}
