//
//  PostCollectionViewCell.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/14/24.
//

import UIKit
import SnapKit
import RxSwift

final class PostCollectionViewCell: BaseCollectionViewCell {
    
    var disposeBag = DisposeBag()
    
    private let categoryLabel = {
        let label = UILabel()
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
    
    private let personImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person.3.fill")
        view.tintColor = .systemGray4
        return view
    }()
    
    private let voteCountLabel = {
        let label = UILabel()
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
        textView.isScrollEnabled = false
        return textView
    }()
    
    let leftButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .customSecondary
        button.layer.opacity = 0.5
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
        return button
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
        label.adjustsFontSizeToFitWidth = true
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
    
    private let profileView = ProfileView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
    
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
        leftVoteRateLabel.text = "\(String(format: "%.1f", percentage(a: item.likes.count, b: item.likes2.count)))%"
        rightVoteRateLabel.text = "\(String(format: "%.1f", percentage(a: item.likes2.count, b: item.likes.count)))%"
        profileView.creatorNickLabel.text = item.creator.nick
        
        if percentage(a: item.likes.count, b: item.likes2.count) != 0 {
            leftVoteRateLabel.snp.remakeConstraints { make in
                make.verticalEdges.equalTo(voteRateStackView)
                make.leading.equalTo(voteRateStackView.snp.leading)
                make.width.equalTo(voteRateStackView.snp.width).multipliedBy(percentage(a: item.likes.count, b: item.likes2.count) / 100)
            }
        }
        
        if item.likes.contains(UserDefaultsManager.shared.userID) {
            leftButton.layer.opacity = 1.0
            rightButton.layer.opacity = 0.5
        } else if item.likes2.contains(UserDefaultsManager.shared.userID) {
            leftButton.layer.opacity = 0.5
            rightButton.layer.opacity = 1.0
        } else {
            leftButton.layer.opacity = 0.5
            rightButton.layer.opacity = 0.5
        }
    }
    
    override func configureHierarchy() {
        contentView.addSubViews(
            [categoryLabel, emptyView, titleLabel,
             createdDateLable, personImageView, voteCountLabel, commentsImageView, commentsCountLabel,
             contentTextView,
             leftButton, vsLabel, rightButton,
             leftVoteCountLabel, diffVoteLabel, diffCountLabel, rightVoteCountLabel,
             voteRateStackView, leftVoteRateLabel, rightVoteRateLabel,
             lineView, profileView]
        )
    }
    
    override func configureConstraints() {
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(16)
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
            make.verticalEdges.equalTo(emptyView)
            make.leading.equalTo(emptyView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-24)        }
        
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
            make.top.equalTo(voteRateStackView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
        
        profileView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom)
            make.height.equalTo(80)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func configureViews() {
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = UIColor.white
        contentView.layer.borderColor = UIColor.customLightGray.cgColor
        contentView.layer.borderWidth = 2
    }
}
