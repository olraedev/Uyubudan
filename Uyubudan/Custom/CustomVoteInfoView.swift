//
//  CustomVoteInfoView.swift
//  Uyubudan
//
//  Created by SangRae Kim on 5/2/24.
//

import UIKit

final class CustomVoteInfoView: BaseView {
    
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
    
    func configureLabelsText(_ item: PostData) {
        leftVoteCountLabel.text = "\(item.likes.count)표"
        diffCountLabel.text = "\(abs(item.likes.count - item.likes2.count))표"
        rightVoteCountLabel.text = "\(item.likes2.count)표"
    }
    
    func configureViewsAlpha(_ state: LikeState) {
        switch state {
        case .none:
            UIView.animate(withDuration: 0.3, animations: {
                self.alpha = 0
            }, completion: { (value: Bool) in
                self.isHidden = true
            })
        default:
            self.isHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                self.alpha = 1
            }, completion:  nil)
        }
    }
    
    override func configureHierarchy() {
        addSubViews([leftVoteCountLabel, diffVoteLabel, diffCountLabel, rightVoteCountLabel])
    }
    
    override func configureConstraints() {
        leftVoteCountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(40)
            make.width.equalTo(100)
            make.bottom.equalToSuperview().offset(-16)
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
            make.trailing.equalToSuperview().offset(-40)
            make.width.equalTo(100)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}
