//
//  HomeView.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/13/24.
//

import UIKit
import RxSwift

final class HomeView: BaseView {
    
    let disposeBag = DisposeBag()
    
    lazy var profileImageView = {
        let view = ProfileImageView(frame: .zero)
        view.isUserInteractionEnabled = true
        view.snp.makeConstraints { make in
            make.size.equalTo(30)
        }
        return view
    }()
    
    lazy var categoryCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: categoryCreateLayout())
        view.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
        view.showsVerticalScrollIndicator = false
        view.refreshControl = refreshControl
        return view
    }()
    
    lazy var refreshControl = {
        let control = UIRefreshControl()
        control.endRefreshing()
        return control
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = self.center
        activityIndicator.style = .large
        activityIndicator.isHidden = true
        activityIndicator.color = .customPrimary
        return activityIndicator
    }()
    
    override func configureHierarchy() {
        addSubViews([categoryCollectionView, collectionView, activityIndicator])
    }
    
    override func configureConstraints() {
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(48)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom)
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    override func configureViews() {
        collectionView.rx.contentOffset
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(with: self) { owner, offset in
                let actualPosition = offset.y
                if actualPosition > 0 {
                    owner.categoryCollectionView.snp.remakeConstraints { make in
                        make.top.equalTo(owner.safeAreaLayoutGuide).offset(16)
                        make.horizontalEdges.equalTo(owner.safeAreaLayoutGuide).inset(24)
                        make.height.equalTo(0)
                    }
                } else {
                    owner.categoryCollectionView.snp.remakeConstraints { make in
                        make.top.equalTo(owner.safeAreaLayoutGuide).offset(16)
                        make.horizontalEdges.equalTo(owner.safeAreaLayoutGuide).inset(24)
                        make.height.equalTo(48)
                    }
                }
                UIView.animate(withDuration: 0.2) {
                    self.layoutIfNeeded()
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func categoryCreateLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.2),
            heightDimension: .estimated(40)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(40)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        group.interItemSpacing = .fixed(8)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = config
        return layout
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            var config = UICollectionLayoutListConfiguration(appearance: .plain)
            config.showsSeparators = false
            
            let section = NSCollectionLayoutSection.list(
                using: config,
                layoutEnvironment: layoutEnvironment
            )
            section.interGroupSpacing = 16
            section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
            
            return section
        }
        
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
}
