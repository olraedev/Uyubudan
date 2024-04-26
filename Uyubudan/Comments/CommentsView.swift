//
//  CommentsView.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/21/24.
//

import UIKit

final class CommentsView: BaseView {
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.register(CreatorCollectionViewCell.self, forCellWithReuseIdentifier: CreatorCollectionViewCell.identifier)
        view.backgroundColor = .clear
        return view
    }()
    
    private let writeView = {
        let view = UIView()
        return view
    }()
    
    private let profileImageView = ProfileImageView(frame: .zero)
    
    let writeTextField = {
        let tf = CustomTextField()
        tf.placeholder = "댓글을 작성해주세요"
        return tf
    }()
    
    let completeButton = {
        let button = PrimaryColorButton()
        button.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    override func configureHierarchy() {
        addSubViews([collectionView, writeView])
        writeView.addSubViews([profileImageView, writeTextField, completeButton])
    }
    
    override func configureConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(writeTextField.snp.top)
        }
        
        writeView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(30)
            make.horizontalEdges.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(30)
        }
        
        writeTextField.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.trailing.equalTo(completeButton.snp.leading).offset(-8)
            make.height.equalTo(30)
            make.centerY.equalToSuperview()
        }
        
        completeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.size.equalTo(30)
        }
    }
    
    override func configureViews() {
        profileImageView.setImage(url: UserDefaultsManager.shared.profileImage)
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
