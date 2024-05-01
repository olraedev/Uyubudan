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
    
    private let categoryLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .black
        return label
    }()
    
    let deleteButton = {
        let button = UIButton()
        button.setTitle("삭제", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 13)
        button.backgroundColor = .clear
        button.isHidden = true
        return button
    }()
    
    private let emptyView = {
        let view = UIView()
        view.backgroundColor = .customPrimary
        return view
    }()
    
    private let titleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    private let createdDateLable = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemGray4
        return label
    }()
    
    let voteCountButton = {
        var configuration = UIButton.Configuration.borderless()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .light)
        configuration.image = UIImage(systemName: "person.3.fill", withConfiguration: imageConfig)
        configuration.imagePadding = 3
        configuration.imagePlacement = .leading
        configuration.baseForegroundColor = .systemGray4
        configuration.buttonSize = .mini
        let button = UIButton(configuration: configuration)
        return button
    }()
    
    let commentsCountButton = {
        var configuration = UIButton.Configuration.borderless()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .light)
        configuration.image = UIImage(systemName: "message.fill", withConfiguration: imageConfig)
        configuration.imagePadding = 3
        configuration.imagePlacement = .leading
        configuration.baseForegroundColor = .systemGray4
        configuration.buttonSize = .mini
        let button = UIButton(configuration: configuration)
        return button
    }()
    
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
        view.image = nil
        view.isHidden = true
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.systemGray6.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let leftButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .customSecondary
        button.layer.opacity = 0.5
        button.clipsToBounds = true
        return button
    }()
    
    private let vsLabel = {
        let label = UILabel()
        label.text = "VS"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .customPrimary
        return label
    }()
    
    let rightButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .customTertiary
        button.layer.opacity = 0.5
        button.clipsToBounds = true
        return button
    }()
    
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
    
    let buttonsView = UIView()
    
    let labelsView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    let voteInfoView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    lazy var verticalStackView = {
        let view = UIStackView(arrangedSubviews: [imageView, buttonsView, labelsView, voteInfoView, lineView, profileView])
        view.axis = .vertical
        view.spacing = 8
        view.backgroundColor = .white
        view.distribution = .fill
        return view
    }()
    
    private let leftVoteCountLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let diffVoteLabel = {
        let label = UILabel()
        label.text = "표차"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemGray4
        label.textAlignment = .center
        return label
    }()
    
    private let diffCountLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let rightVoteCountLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let leftVoteRateLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .customSecondary
        return label
    }()
    
    private lazy var voteRateStackView = {
        let view = UIStackView(arrangedSubviews: [leftVoteRateLabel, rightVoteRateLabel])
        view.distribution = .fillProportionally
        view.spacing = 0
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let rightVoteRateLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .customTertiary
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
        imageView.isHidden = true
        labelsView.isHidden = true
        voteInfoView.isHidden = true
        deleteButton.isHidden = true
        profileView.followButton.isHidden = false
        leftButton.setBackgroundImage(nil, for: .normal)
        rightButton.setBackgroundImage(nil, for: .normal)
        leftButton.setImage(nil, for: .normal)
        rightButton.setImage(nil, for: .normal)
    }
    
    func configureCell(_ item: PostData, myFollowingList: [String]) {
        let userID = UserDefaultsManager.userID
        
        categoryLabel.text = item.content3
        deleteButton.isHidden = userID == item.creator.userID ? false : true
        titleLabel.text = item.title
        createdDateLable.text = ISODateFormatManager.shared.ISODateFormatToString(item.createdAt)
        voteCountButton.setTitle("\(item.likes.count + item.likes2.count)", for: .normal)
        commentsCountButton.setTitle("\(item.comments.count)", for: .normal)
        contentTextView.text = item.content
        leftVoteCountLabel.text = "\(item.likes.count)표"
        diffCountLabel.text = "\(abs(item.likes.count - item.likes2.count))표"
        rightVoteCountLabel.text = "\(item.likes2.count)표"
        leftVoteRateLabel.text = "\(String(format: "%.1f", percentage(a: item.likes.count, b: item.likes2.count)))%"
        rightVoteRateLabel.text = "\(String(format: "%.1f", percentage(a: item.likes2.count, b: item.likes.count)))%"
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
        
        if item.likes.count + item.likes2.count != 0 {
            leftVoteRateLabel.snp.remakeConstraints { make in
                make.verticalEdges.equalTo(voteRateStackView)
                make.leading.equalTo(voteRateStackView.snp.leading)
                make.width.equalTo(voteRateStackView.snp.width).multipliedBy(percentage(a: item.likes.count, b: item.likes2.count) / 100)
            }
        } else {
            leftVoteRateLabel.snp.remakeConstraints { make in
                make.verticalEdges.equalTo(voteRateStackView)
                make.leading.equalTo(voteRateStackView.snp.leading)
                make.width.equalTo(voteRateStackView.snp.width).multipliedBy(0.5)
            }
        }
        
        if item.likes.contains(UserDefaultsManager.userID) {
            leftButton.layer.opacity = 1.0
            rightButton.layer.opacity = 0.5
            
            voteInfoView.isHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                self.voteInfoView.alpha = 1
            }, completion:  nil)
        } else if item.likes2.contains(UserDefaultsManager.userID) {
            leftButton.layer.opacity = 0.5
            rightButton.layer.opacity = 1.0
            
            voteInfoView.isHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                self.voteInfoView.alpha = 1
            }, completion:  nil)
        } else {
            leftButton.layer.opacity = 0.5
            rightButton.layer.opacity = 0.5
            
            UIView.animate(withDuration: 0.3, animations: {
                self.voteInfoView.alpha = 0
            }, completion: { (value: Bool) in
                self.voteInfoView.isHidden = true
            })
        }
        
        if item.files.count == 0 {
            imageView.isHidden = true
            labelsView.isHidden = true
            leftButton.setTitle(item.content1, for: .normal)
            rightButton.setTitle(item.content2, for: .normal)
            leftButton.setBackgroundImage(nil, for: .normal)
            rightButton.setBackgroundImage(nil, for: .normal)
        } else if item.files.count == 1 {
            imageView.isHidden = false
            labelsView.isHidden = true
            imageView.setImage(url: item.files[0])
            leftButton.setTitle(item.content1, for: .normal)
            rightButton.setTitle(item.content2, for: .normal)
            leftButton.setBackgroundImage(nil, for: .normal)
            rightButton.setBackgroundImage(nil, for: .normal)
        } else if item.files.count == 2 {
            imageView.isHidden = true
            labelsView.isHidden = false
            leftButton.setImageWithURL(item.files[0])
            rightButton.setImageWithURL(item.files[1])
            leftLabel.text = item.content1
            rightLabel.text = item.content2
        }
    }
    
    override func configureHierarchy() {
        contentView.addSubViews(
            [categoryLabel, deleteButton, emptyView, titleLabel,
             createdDateLable, voteCountButton, commentsCountButton,
             contentTextView,
             verticalStackView]
        )
        
        buttonsView.addSubViews([leftButton, vsLabel, rightButton])
        
        labelsView.addSubViews([leftLabel, rightLabel])
        
        voteInfoView.addSubViews(
            [leftVoteCountLabel, diffVoteLabel, diffCountLabel, rightVoteCountLabel, voteRateStackView, leftVoteRateLabel, rightVoteRateLabel]
        )
    }
    
    override func configureConstraints() {
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(16)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(16)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.top)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(13)
            make.width.equalTo(3)
            make.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(emptyView.snp.verticalEdges)
            make.leading.equalTo(emptyView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        createdDateLable.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel.snp.leading)
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
        
        buttonsView.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        
        labelsView.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        
        voteInfoView.snp.makeConstraints { make in
            make.height.equalTo(90)
        }
        
        leftButton.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.leading.equalToSuperview().offset(40)
        }
        
        vsLabel.snp.makeConstraints { make in
            make.centerY.equalTo(leftButton)
            make.centerX.equalToSuperview()
        }
        
        rightButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-40)
            make.size.equalTo(100)
        }
        
        leftLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.horizontalEdges.equalTo(leftButton)
            make.height.equalTo(20)
        }
        
        rightLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.horizontalEdges.equalTo(rightButton)
            make.height.equalTo(20)
        }
        
        leftVoteCountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.horizontalEdges.equalTo(leftButton)
            make.bottom.equalTo(voteRateStackView.snp.top).offset(-16)
        }
        
        diffVoteLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
        }
        
        diffCountLabel.snp.makeConstraints { make in
            make.top.equalTo(diffVoteLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(24)
        }
        
        rightVoteCountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.horizontalEdges.equalTo(rightButton)
            make.bottom.equalTo(voteRateStackView.snp.top).offset(-16)
        }
        
        voteRateStackView.snp.makeConstraints { make in
            make.top.equalTo(diffCountLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(24)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        leftVoteRateLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(voteRateStackView)
            make.leading.equalTo(voteRateStackView.snp.leading)
            make.width.equalTo(voteRateStackView.snp.width).multipliedBy(0.5)
        }
        
        rightVoteRateLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(voteRateStackView)
            make.leading.equalTo(leftVoteRateLabel.snp.trailing)
            make.trailing.equalTo(voteRateStackView.snp.trailing)
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
