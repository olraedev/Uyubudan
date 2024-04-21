//
//  CommentsView.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/21/24.
//

import UIKit

final class CommentsView: BaseView {
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(CommentsTableViewCell.self, forCellReuseIdentifier: CommentsTableViewCell.identifier)
        view.backgroundColor = .clear
        view.rowHeight = UITableView.automaticDimension
        return view
    }()
    
    let writeTextField = {
        let tf = CustomTextField()
        tf.placeholder = "댓글을 작성해주세요"
        return tf
    }()
    
    override func configureHierarchy() {
        addSubViews([tableView])
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
