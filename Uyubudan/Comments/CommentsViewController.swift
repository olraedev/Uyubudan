//
//  CommentsViewController.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/21/24.
//

import UIKit
import RxSwift
import RxCocoa

final class CommentsViewController: BaseViewController {
    
    private let commentsView = CommentsView()
    let viewModel = CommentsViewModel()
    
    override func loadView() {
        super.loadView()
        
        view = commentsView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.viewWillAppearTrigger.accept(())
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        viewModel.dismiss?()
    }
    
    override func bind() {
        let comment = commentsView.writeTextField.rx.text
        let completeButton = commentsView.completeButton.rx.tap
        
        let input = CommentsViewModel.Input(
            comment: comment,
            completeButton: completeButton
        )
        let output = viewModel.transform(input: input)
        
        output.comments
            .drive(commentsView.collectionView.rx.items(cellIdentifier: CreatorCollectionViewCell.identifier, cellType: CreatorCollectionViewCell.self)) { row, element, cell in
                cell.configureCell(element)
                
                cell.deleteButton.rx.tap
                    .map { return element }
                    .bind(with: self, onNext: { owner, comment in
                        owner.showAlert(title: nil, message: "정말 삭제하시겠습니까?") {
                            owner.viewModel.deleteButtonTapped.accept(comment)
                        }
                    })
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        output.errorMessage
            .drive(with: self) { owner, error in
                owner.showAlert(title: nil, message: error.errorDescription)
            }
            .disposed(by: disposeBag)
    }
}
