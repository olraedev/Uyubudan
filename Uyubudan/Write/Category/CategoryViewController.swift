//
//  CategoryViewController.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/21/24.
//

import UIKit
import RxSwift
import RxCocoa

final class CategoryViewController: WriteViewController {
    
    private let categoryView = CategoryView()
    private let viewModel = CategoryViewModel()
    
    override func loadView() {
        super.loadView()
        
        view = categoryView
    }
    
    override func bind() {
        let categorySelected = categoryView.categoryPickerView.rx.modelSelected(String.self)
        let completeButtonTapped = categoryView.completeButton.rx.tap
        
        let input = CategoryViewModel.Input(categorySelected: categorySelected)
        let output = viewModel.transform(input: input)
        
        output.categoryList
            .drive(categoryView.categoryPickerView.rx.itemTitles) { _, item in
                return item
            }
            .disposed(by: disposeBag)
        
        output.selected
            .drive(categoryView.completeButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.selected
            .map { [weak self] state in
                self?.buttonColor(state)
            }
            .drive(categoryView.completeButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        completeButtonTapped
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(ContentsViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureNavigationItem() {
        super.configureNavigationItem()
        
        navigationItem.leftBarButtonItem?.isHidden = true
    }
}
