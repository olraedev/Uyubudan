//
//  CardCollectionViewCell.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/22/24.
//

import UIKit

final class CardCollectionViewCell: BaseCollectionViewCell {

    private let categoryLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .black
        label.text = "작명"
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
        label.text = "타이틀라베에에에ㅔㅇㄹ"
        return label
    }()
    
    private let leftVoteLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .customSecondary
        label.adjustsFontSizeToFitWidth = true
        label.text = "짜장"
        return label
    }()
    
    private let rightVoteLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .customTertiary
        label.adjustsFontSizeToFitWidth = true
        label.text = "짬뽕"
        return label
    }()
    
    private lazy var voteRateStackView = {
        let view = UIStackView(arrangedSubviews: [leftVoteLabel, rightVoteLabel])
        view.distribution = .fillProportionally
        view.spacing = 0
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let voteCountButton = {
        var configuration = UIButton.Configuration.borderless()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .light)
        configuration.image = UIImage(systemName: "person.3.fill", withConfiguration: imageConfig)
        configuration.imagePadding = 3
        configuration.imagePlacement = .leading
        configuration.baseForegroundColor = .systemGray4
        configuration.buttonSize = .mini
        let button = UIButton(configuration: configuration)
        button.setTitle("3", for: .normal)
        return button
    }()
    
    private let commentsCountButton = {
        var configuration = UIButton.Configuration.borderless()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .light)
        configuration.image = UIImage(systemName: "message.fill", withConfiguration: imageConfig)
        configuration.imagePadding = 3
        configuration.imagePlacement = .leading
        configuration.baseForegroundColor = .systemGray4
        configuration.buttonSize = .mini
        let button = UIButton(configuration: configuration)
        button.setTitle("3", for: .normal)
        return button
    }()
    
    func configureCell(_ item: PostData) {
        categoryLabel.text = item.content3
        titleLabel.text = item.title
        leftVoteLabel.text = item.content1
        rightVoteLabel.text = item.content2
        voteCountButton.setTitle("\(item.likes.count + item.likes2.count)", for: .normal)
        commentsCountButton.setTitle("\(item.comments.count)", for: .normal)
        
        if item.likes.count + item.likes2.count != 0 {
            leftVoteLabel.snp.remakeConstraints { make in
                make.verticalEdges.equalTo(voteRateStackView)
                make.leading.equalTo(voteRateStackView.snp.leading)
                make.width.equalTo(voteRateStackView.snp.width).multipliedBy(percentage(a: item.likes.count, b: item.likes2.count) / 100)
            }
        } else {
            leftVoteLabel.snp.remakeConstraints { make in
                make.verticalEdges.equalTo(voteRateStackView)
                make.leading.equalTo(voteRateStackView.snp.leading)
                make.width.equalTo(voteRateStackView.snp.width).multipliedBy(0.5)
            }
        }
    }
    
    override func configureHierarchy() {
        contentView.addSubViews([
            categoryLabel, emptyView, titleLabel, voteRateStackView,
            voteCountButton, commentsCountButton
        ])
    }
    
    override func configureConstraints() {
        categoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
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
            make.trailing.equalToSuperview().offset(-24)
        }
        
        leftVoteLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(voteRateStackView)
            make.leading.equalTo(voteRateStackView.snp.leading)
        }
        
        rightVoteLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(voteRateStackView)
            make.trailing.equalTo(voteRateStackView.snp.trailing)
        }
        
        voteRateStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.bottom.equalTo(voteCountButton.snp.top).offset(-24)
        }
        
        voteCountButton.snp.makeConstraints { make in
            make.trailing.equalTo(commentsCountButton.snp.leading).offset(-8)
            make.bottom.equalTo(commentsCountButton.snp.bottom)
            make.height.equalTo(20)
        }
        
        commentsCountButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(20)
        }
    }
    
    override func configureViews() {
        layer.masksToBounds = true
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.customLightGray.cgColor
    }
}
