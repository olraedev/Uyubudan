//
//  CommentsViewController.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/21/24.
//

import UIKit
import RxSwift
import RxCocoa
import PanModal

final class CommentsViewController: BaseViewController {
    
    private let commentsView = CommentsView()
    let viewModel = CommentsViewModel()
    
    override func loadView() {
        super.loadView()
        
        view = commentsView
    }
    
    override func bind() {
        let viewDidLoadTrigger = rx.viewWillAppear
        
        let input = CommentsViewModel.Input(
            viewDidLoadTrigger: viewDidLoadTrigger
        )
        let output = viewModel.transform(input: input)
        
        output.comments
            .drive(commentsView.tableView.rx.items(cellIdentifier: CommentsTableViewCell.identifier, cellType: CommentsTableViewCell.self)) { row, element, cell in
                print(element)
                cell.configureCell(element)
            }
            .disposed(by: disposeBag)
    }
}

extension CommentsViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        commentsView.tableView
    }
    
    var shortFormHeight: PanModalHeight {
        .contentHeight(UIScreen.main.bounds.height * 0.4)
    }
    
    var transitionAnimationOptions: UIView.AnimationOptions {
        return [.allowUserInteraction, .beginFromCurrentState]
    }

    var shouldRoundTopCorners: Bool {
        return true
    }

    var showDragIndicator: Bool {
        return true
    }
    
    var allowsDragToDismiss: Bool {
        return true
    }
    
    var allowsTapToDismiss: Bool {
        return true
    }
    
    var anchorModalToLongForm: Bool {
        return true
    }
    
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(80)
    }
}
