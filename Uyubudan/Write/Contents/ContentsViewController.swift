//
//  ContentViewController.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/21/24.
//

import UIKit
import RxSwift
import RxCocoa

final class ContentsViewController: WriteViewController {
    
    private let contentsView = ContentsView()
    private let viewModel = ContentsViewModel()
    
    override func loadView() {
        super.loadView()
        
        view = contentsView
    }
    
    override func bind() {
        let title = contentsView.titleTextField.rx.text
        let content = contentsView.contentTextView.rx.text
        let completeButtonTapped = contentsView.completeButton.rx.tap
        
        let input = ContentsViewModel.Input(
            title: title,
            content: content
        )
        let output = viewModel.transform(input: input)
        
        let validation = Observable.combineLatest(output.titleValidation, output.contentValidation).map { $0 && $1}
        
        validation
            .bind(to: contentsView.completeButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        validation
            .map { [weak self] state in
                self?.buttonColor(state)
            }
            .bind(to: contentsView.completeButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        completeButtonTapped
            .bind(with: self) { owner, _ in
                TempDataRepoManager.shared.title = owner.contentsView.titleTextField.text!
                TempDataRepoManager.shared.content = owner.contentsView.contentTextView.text!
                
                let vc = SelectViewController()
                
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        contentsView.contentTextView.rx.didChange
            .bind(with: self) { owner, _ in
                owner.contentsView.placeHolder.isHidden = true
                
                let size = CGSize(width: owner.contentsView.contentTextView.frame.width, height: .infinity)
                let estimatedSize = owner.contentsView.contentTextView.sizeThatFits(size)
                let isMaxHeight = estimatedSize.height >= 200
                
                guard isMaxHeight != owner.contentsView.contentTextView.isScrollEnabled else { return }
                owner.contentsView.contentTextView.isScrollEnabled = isMaxHeight
                owner.contentsView.contentTextView.reloadInputViews()
                owner.contentsView.setNeedsUpdateConstraints()
            }
            .disposed(by: disposeBag)
    }
    
    override func configureNavigationItem() {
        super.configureNavigationItem()
    }
}
