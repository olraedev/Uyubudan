//
//  CustomVoteRateView.swift
//  Uyubudan
//
//  Created by SangRae Kim on 5/2/24.
//

import UIKit

final class CustomVoteRateView: BaseView {
    
    private let leftVoteRateLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .customSecondary
        return label
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
    
    private lazy var voteRateStackView = {
        let view = UIStackView(arrangedSubviews: [leftVoteRateLabel, rightVoteRateLabel])
        view.distribution = .fillProportionally
        view.spacing = 0
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    func configureLabelsText(_ item: PostData) {
        leftVoteRateLabel.text = "\(String(format: "%.1f", percentage(a: item.likes.count, b: item.likes2.count)))%"
        rightVoteRateLabel.text = "\(String(format: "%.1f", percentage(a: item.likes2.count, b: item.likes.count)))%"
    }
    
    func changeViewsConstraints(_ item: PostData) {
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
    }
    
    override func configureHierarchy() {
        addSubViews([leftVoteRateLabel, rightVoteRateLabel, voteRateStackView])
    }
    
    override func configureConstraints() {
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
        
        voteRateStackView.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
    }
}
