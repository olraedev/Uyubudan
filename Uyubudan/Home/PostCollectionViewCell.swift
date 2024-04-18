//
//  PostCollectionViewCell.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/14/24.
//

import UIKit
import SnapKit

final class PostCollectionViewCell: BaseCollectionViewCell {
    
    private let categoryLabel = {
        let label = UILabel()
        label.text = "작명"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .black
        return label
    }()
    
    private let emptyView = {
        let view = UIView()
        view.backgroundColor = .customPrimary
        return view
    }()
    
    private let titleLabel = {
        let label = UILabel()
        label.text = "프로젝트 이름 정해주세요..!"
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    private let createdDateLable = {
        let label = UILabel()
        label.text = "6시간전"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemGray4
        return label
    }()
    
    private let personImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person.3.fill")
        view.tintColor = .systemGray4
        return view
    }()
    
    private let voteCountLabel = {
        let label = UILabel()
        label.text = "123,456"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemGray4
        return label
    }()
    
    private let commentsImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "message.fill")
        view.tintColor = .systemGray4
        return view
    }()
    
    private let commentsCountLabel = {
        let label = UILabel()
        label.text = "12,345"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemGray4
        return label
    }()
    
    private let contentTextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.textAlignment = .justified
        textView.font = .systemFont(ofSize: 14)
        textView.textColor = .black
        textView.text = "onewofnowenfewnfpwnefpnwefpnwefnwponewofnowenfewnfpwnefpnwefpnwefnwponewofnowenfewnfpwnefpnwefpnwefnwponewofnowenfewnfpwnefpnwefpnwefnwponewofnowenfewnfpwnefpnwefpnwefnwponewofnowenfewnfpwnefpnwefpnwefnwponewofnowenfewnfpwnefpnwefpnwefnwp"
        textView.isScrollEnabled = false
        return textView
    }()
    
    private let leftButton = {
        let button = UIButton()
        button.setTitle("왼쪽", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .customSecondary
        button.layer.opacity = 0.5
        // button.layer.shadowRadius = 2
        // button.layer.shadowOffset = CGSize(width: 0, height: 3)
        // button.layer.shadowOpacity = 0.25
        // button.layer.shadowColor = UIColor.black.cgColor
        // button.layer.masksToBounds = false
        return button
    }()
    
    private let vsLabel = {
        let label = UILabel()
        label.text = "VS"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .customPrimary
        return label
    }()
    
    private let rightButton = {
        let button = UIButton()
        button.setTitle("오른쪽", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .customTertiary
        button.layer.opacity = 0.5
        // button.layer.shadowRadius = 2
        // button.layer.shadowOffset = CGSize(width: 0, height: 3)
        // button.layer.shadowOpacity = 0.25
        // button.layer.shadowColor = UIColor.black.cgColor
        // button.layer.masksToBounds = false
        return button
    }()
    
    private let leftVoteCountLabel = {
        let label = UILabel()
        label.text = "100표"
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
        label.text = "15표"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let rightVoteCountLabel = {
        let label = UILabel()
        label.text = "100표"
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let leftRateView = {
        let view = UIView()
        view.backgroundColor = .customSecondary
        return view
    }()
    
    private let rightRateView = {
        let view = UIView()
        view.backgroundColor = .customTertiary
        return view
    }()
    
    private let leftVoteRateLabel = {
        let label = UILabel()
        label.text = "62.3%"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var voteRateStackView = {
        let view = UIStackView(arrangedSubviews: [leftRateView, rightRateView])
        view.distribution = .fillProportionally
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let rightVoteRateLabel = {
        let label = UILabel()
        label.text = "37.7%"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let lineView = {
        let view = UIView()
        view.backgroundColor = .customLightGray
        return view
    }()
    
    private let profileImageView = {
        let view = ProfileImageView(frame: .zero)
        view.image = UIImage(systemName: "person.fill")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let creatorNickLabel = {
        let label = UILabel()
        label.text = "고래밥"
        label.font = .boldSystemFont(ofSize: 13)
        label.textColor = .black
        return label
    }()
    
    private let creatorLabel = {
        let label = UILabel()
        label.text = "투표게시자"
        label.font = .systemFont(ofSize: 11)
        label.textColor = .systemGray4
        return label
    }()
    
    private let detailProfileButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .darkGray
        button.backgroundColor = .customLightGray
        return button
    }()
    
    func configureCell(_ item: PostData) {
        categoryLabel.text = "기타"
        titleLabel.text = item.title
        createdDateLable.text = item.createdAt.timeIntervalSinceNow
        voteCountLabel.text = "\(item.likes.count + item.likes2.count)"
        commentsCountLabel.text = "\(item.comments.count)"
        contentTextView.text = item.content
        leftButton.setTitle(item.content1, for: .normal)
        rightButton.setTitle(item.content2, for: .normal)
        leftVoteCountLabel.text = "\(item.likes.count)표"
        diffCountLabel.text = "\(abs(item.likes.count - item.likes2.count))표"
        rightVoteCountLabel.text = "\(item.likes2.count)표"
        leftVoteRateLabel.text = "\(Double(item.likes.count) / (Double(item.likes.count + item.likes2.count)) * 100)%"
        rightVoteRateLabel.text = "\(Double(item.likes2.count) / (Double(item.likes.count + item.likes2.count)) * 100)%"
        creatorNickLabel.text = item.creator.nick
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        profileImageView.layer.cornerRadius = 0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        detailProfileButton.layoutIfNeeded()
        detailProfileButton.layer.cornerRadius = detailProfileButton.frame.width / 2
    }
    
    override func configureHierarchy() {
        contentView.addSubview(categoryLabel)
        contentView.addSubview(emptyView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(createdDateLable)
        contentView.addSubview(personImageView)
        contentView.addSubview(voteCountLabel)
        contentView.addSubview(commentsImageView)
        contentView.addSubview(commentsCountLabel)
        contentView.addSubview(contentTextView)
        contentView.addSubview(leftButton)
        contentView.addSubview(vsLabel)
        contentView.addSubview(rightButton)
        contentView.addSubview(leftVoteCountLabel)
        contentView.addSubview(diffVoteLabel)
        contentView.addSubview(diffCountLabel)
        contentView.addSubview(rightVoteCountLabel)
        contentView.addSubview(voteRateStackView)
        contentView.addSubview(leftVoteRateLabel)
        contentView.addSubview(rightVoteRateLabel)
        contentView.addSubview(lineView)
        contentView.addSubview(profileImageView)
        contentView.addSubview(creatorNickLabel)
        contentView.addSubview(creatorLabel)
        contentView.addSubview(detailProfileButton)
    }
    
    override func configureConstraints() {
        categoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(16)
        }
        
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.width.equalTo(8)
            make.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(emptyView)
            make.leading.equalTo(emptyView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(24)
        }
        
        createdDateLable.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel.snp.leading)
            make.height.equalTo(16)
        }
        
        personImageView.snp.makeConstraints { make in
            make.centerY.equalTo(createdDateLable)
            make.leading.equalTo(createdDateLable.snp.trailing).offset(16)
            make.size.equalTo(20)
        }
        
        voteCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(personImageView)
            make.leading.equalTo(personImageView.snp.trailing).offset(3)
            make.height.equalTo(16)
        }
        
        commentsImageView.snp.makeConstraints { make in
            make.centerY.equalTo(createdDateLable)
            make.trailing.equalTo(commentsCountLabel.snp.leading).offset(-3)
            make.size.equalTo(20)
        }
        
        commentsCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(createdDateLable)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(16)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(createdDateLable.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        leftButton.snp.makeConstraints { make in
            make.top.equalTo(contentTextView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(40)
            make.size.equalTo(100)
        }
        
        vsLabel.snp.makeConstraints { make in
            make.centerY.equalTo(leftButton)
            make.centerX.equalToSuperview()
        }
        
        rightButton.snp.makeConstraints { make in
            make.top.equalTo(contentTextView.snp.bottom).offset(16)
            make.trailing.equalToSuperview().offset(-40)
            make.size.equalTo(100)
        }
        
        leftVoteCountLabel.snp.makeConstraints { make in
            make.top.equalTo(leftButton.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(leftButton)
            make.bottom.equalTo(voteRateStackView.snp.top).offset(-16)
        }
        
        diffVoteLabel.snp.makeConstraints { make in
            make.top.equalTo(leftButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        diffCountLabel.snp.makeConstraints { make in
            make.top.equalTo(diffVoteLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(24)
        }
        
        rightVoteCountLabel.snp.makeConstraints { make in
            make.top.equalTo(rightButton.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(rightButton)
            make.bottom.equalTo(voteRateStackView.snp.top).offset(-16)
        }
        
        voteRateStackView.snp.makeConstraints { make in
            make.top.equalTo(diffCountLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(24)
        }
        
        leftRateView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview()
        }
        
        rightRateView.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalToSuperview()
        }
        
        leftVoteRateLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(voteRateStackView)
            make.leading.equalTo(voteRateStackView.snp.leading).offset(8)
        }
        
        rightVoteRateLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(voteRateStackView)
            make.trailing.equalTo(voteRateStackView.snp.trailing).offset(-8)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(voteRateStackView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
            make.size.equalTo(40)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        creatorNickLabel.snp.makeConstraints { make in
            make.bottom.equalTo(profileImageView.snp.centerY)
            make.leading.equalTo(profileImageView.snp.trailing).offset(16)
            make.height.equalTo(16)
        }
        
        creatorLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.centerY)
            make.leading.equalTo(creatorNickLabel)
            make.height.equalTo(16)
        }
        
        detailProfileButton.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.trailing.equalToSuperview().offset(-24)
            make.size.equalTo(30)
        }
    }
    
    override func configureViews() {
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = UIColor.white
        contentView.layer.borderColor = UIColor.customLightGray.cgColor
        contentView.layer.borderWidth = 2
    }
}
