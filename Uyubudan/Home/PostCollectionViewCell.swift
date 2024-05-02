//
//  PostCollectionViewCell.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/14/24.
//

import UIKit
import Kingfisher
import RxSwift

final class PostCollectionViewCell: BaseCollectionViewCell {
    
    let postHeaderView = PostHeaderView()
    
    private let createdDateLable = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemGray4
        return label
    }()
    
    let voteCountButton = CustomImageButton(image: "person.3.fill")
    
    let commentsCountButton = CustomImageButton(image: "message.fill")
    
    private let contentTextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.textAlignment = .justified
        textView.font = .systemFont(ofSize: 14)
        textView.textColor = .black
        textView.isScrollEnabled = false
        return textView
    }()
    
    private let imageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.systemGray6.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let customVoteButtonsView = CustomVoteButtonsView()
    
    private let leftLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let rightLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let labelsView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    let customVoteInfoView = CustomVoteInfoView()
    
    let customVoteRateView = CustomVoteRateView()
    
    private let lineView = {
        let view = UIView()
        view.backgroundColor = .customLightGray
        return view
    }()
    
    let tapGesture = UITapGestureRecognizer()
    
    lazy var profileView = {
        let view = CustomProfileView()
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    lazy var verticalStackView = {
        let view = UIStackView(arrangedSubviews: [imageView, customVoteButtonsView, labelsView, customVoteInfoView, customVoteRateView, lineView, profileView])
        view.distribution = .fillProportionally
        view.axis = .vertical
        view.spacing = 8
        view.backgroundColor = .white
        view.alignment = .fill
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
        imageView.isHidden = true
        imageView.image = nil
        labelsView.isHidden = true
        customVoteInfoView.isHidden = true
        postHeaderView.deleteButton.isHidden = true
        profileView.followButton.isHidden = true
        verticalStackView = UIStackView()
        customVoteButtonsView.leftButton.setBackgroundImage(nil, for: .normal)
        customVoteButtonsView.rightButton.setBackgroundImage(nil, for: .normal)
        customVoteButtonsView.leftButton.setImage(nil, for: .normal)
        customVoteButtonsView.rightButton.setImage(nil, for: .normal)
    }
    
    func configureCell(_ item: PostData, myFollowingList: [String]) {
        let userID = UserDefaultsManager.userID
        
        postHeaderView.configureViewWithPostData(item, userID: userID)
        createdDateLable.text = ISODateFormatManager.shared.ISODateFormatToString(item.createdAt)
        voteCountButton.setTitle("\(item.likes.count + item.likes2.count)", for: .normal)
        commentsCountButton.setTitle("\(item.comments.count)", for: .normal)
        contentTextView.text = item.content
        customVoteButtonsView.configureButtonsTitle(item)
        customVoteInfoView.configureLabelsText(item)
        customVoteRateView.configureLabelsText(item)
        profileView.creatorNickLabel.text = item.creator.nick
        profileView.profileImageView.setImage(url: item.creator.profileImage)
        
        if userID == item.creator.userID {
            profileView.followButton.isHidden = true
        }
        else {
            if myFollowingList.contains(item.creator.userID) {
                profileView.followButton.setTitle("팔로잉", for: .normal)
                profileView.followButton.setTitleColor(.darkGray, for: .normal)
                profileView.followButton.backgroundColor = .customLightGray
            } else {
                profileView.followButton.setTitle("팔로우", for: .normal)
                profileView.followButton.setTitleColor(.darkGray, for: .normal)
                profileView.followButton.backgroundColor = .customTertiary
            }
        }
        
        customVoteRateView.changeViewsConstraints(item)
        
        if item.likes.contains(userID) {
            customVoteButtonsView.configureButtonsOpacity(.left)
            customVoteInfoView.configureViewsAlpha(.left)
            customVoteRateView.isHidden = false
        } else if item.likes2.contains(userID) {
            customVoteButtonsView.configureButtonsOpacity(.right)
            customVoteInfoView.configureViewsAlpha(.right)
            customVoteRateView.isHidden = false
        } else {
            customVoteButtonsView.configureButtonsOpacity(.none)
            customVoteInfoView.configureViewsAlpha(.none)
            customVoteRateView.isHidden = true
        }
        
        if item.files.count == 0 {
            imageView.isHidden = true
            labelsView.isHidden = true
        } else if item.files.count == 1 {
            imageView.isHidden = false
            imageView.setImage(url: item.files[0])
            labelsView.isHidden = true
        } else if item.files.count == 2 {
            imageView.isHidden = true
            labelsView.isHidden = false
            leftLabel.text = item.content1
            rightLabel.text = item.content2
        }
    }
    
    override func configureHierarchy() {
        contentView.addSubViews(
            [postHeaderView,
             createdDateLable, voteCountButton, commentsCountButton,
             contentTextView,
             verticalStackView]
        )
        
        labelsView.addSubViews([leftLabel, rightLabel])
    }
    
    override func configureConstraints() {
        postHeaderView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        
        createdDateLable.snp.makeConstraints { make in
            make.top.equalTo(postHeaderView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(16)
        }
        
        voteCountButton.snp.makeConstraints { make in
            make.centerY.equalTo(createdDateLable)
            make.leading.equalTo(createdDateLable.snp.trailing).offset(8)
            make.height.equalTo(16)
        }
        
        commentsCountButton.snp.makeConstraints { make in
            make.centerY.equalTo(createdDateLable)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(16)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(createdDateLable.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.top.equalTo(contentTextView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().offset(-8)
        }
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(imageView.snp.width).multipliedBy(0.5)
        }
        
        customVoteButtonsView.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        
        labelsView.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        
        leftLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.horizontalEdges.equalTo(customVoteButtonsView.leftButton)
            make.height.equalTo(20)
        }
        
        rightLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.horizontalEdges.equalTo(customVoteButtonsView.rightButton)
            make.height.equalTo(20)
        }
        
        customVoteInfoView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        customVoteRateView.snp.makeConstraints { make in
            make.height.equalTo(24)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        
        profileView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
    
    override func configureViews() {
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = UIColor.white
        contentView.layer.borderColor = UIColor.customLightGray.cgColor
        contentView.layer.borderWidth = 2
    }
}
