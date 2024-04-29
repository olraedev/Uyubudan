//
//  MypageView.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/22/24.
//

import UIKit

final class ProfileView: BaseView {
    
    private let profileImageView = ProfileImageView(frame: .zero)
    
    private let nicknamelabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.text = "adfasdf"
        label.textColor = .black
        return label
    }()
    
    let postNumber = {
        let button = UIButton()
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        return button
    }()
    
    let followersButton = {
        let button = UIButton()
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        return button
    }()
    
    let followingButton = {
        let button = UIButton()
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        return button
    }()
    
    let segment = {
        let items = ["게시한 투표", "참여한 투표"]
        let seg = UISegmentedControl(items: items)
        seg.selectedSegmentIndex = 0
        seg.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        seg.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        seg.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)
        ], for: .normal)
        seg.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.customPrimary,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)
        ], for: .selected)
        return seg
    }()
    
    lazy var underLineView = {
        let view = UIView()
        view.backgroundColor = .customPrimary
        return view
    }()
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    let settingBarButtonItem = {
        let item = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"))
        item.tintColor = .black
        return item
    }()
    
    let editBarButtonItem = {
        let item = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"))
        item.tintColor = .black
        return item
    }()
    
    let dismissButton = {
        let item = UIBarButtonItem(image: UIImage(systemName: "xmark"))
        item.tintColor = .black
        return item
    }()
    
    override func configureHierarchy() {
        addSubViews(
            [profileImageView, nicknamelabel, 
             postNumber, followersButton, followingButton,
             segment, underLineView, collectionView]
        )
    }
    
    override func configureConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.leading.equalToSuperview().offset(32)
            make.size.equalTo(100)
        }
        
        nicknamelabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top).offset(8)
            make.leading.equalTo(profileImageView.snp.trailing).offset(24)
            make.height.equalTo(30)
        }
        
        postNumber.snp.makeConstraints { make in
            make.top.equalTo(nicknamelabel.snp.bottom).offset(8)
            make.leading.equalTo(profileImageView.snp.trailing).offset(16)
            make.bottom.equalTo(profileImageView.snp.bottom)
            make.width.equalTo(50)
        }
        
        followersButton.snp.makeConstraints { make in
            make.verticalEdges.equalTo(postNumber)
            make.leading.equalTo(postNumber.snp.trailing).offset(16)
            make.width.equalTo(50)
        }
        
        followingButton.snp.makeConstraints { make in
            make.verticalEdges.equalTo(postNumber)
            make.leading.equalTo(followersButton.snp.trailing).offset(16)
            make.width.equalTo(50)
        }
        
        segment.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(40)
        }
        
        underLineView.snp.makeConstraints { make in
            make.top.equalTo(segment.snp.bottom)
            make.height.equalTo(2)
            make.leading.equalTo(segment.snp.leading)
            make.width.equalTo(segment.snp.width).dividedBy(segment.numberOfSegments)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(underLineView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func configureViews(_ item: ProfileModel) {
        profileImageView.setImage(url: item.profileImage)
        nicknamelabel.text = item.nickname
        postNumber.setTitle("\(item.posts.count)\n게시물", for: .normal)
        followersButton.setTitle("\(item.followers.count)\n팔로워", for: .normal)
        followingButton.setTitle("\(item.following.count)\n팔로잉", for: .normal)
    }
    
    func changeUnderLineView() {
        let segmentIndex = CGFloat(segment.selectedSegmentIndex)
        let segmentWidth = segment.frame.width / CGFloat(segment.numberOfSegments)
        let leading = segmentIndex * segmentWidth
        
        UIView.animate(withDuration: 0.3) { [weak self] () in
            guard let self else { return }
            self.underLineView.snp.updateConstraints { make in
                make.leading.equalTo(self.segment).inset(leading)
            }
            self.layoutIfNeeded()
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}
