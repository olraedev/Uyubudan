//
//  FollowViewController.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/25/24.
//

import UIKit
import RxSwift
import RxCocoa

final class FollowViewController: BaseViewController {
    
    private let followView = FollowView()
    let viewModel = FollowViewModel()
    
    override func loadView() {
        super.loadView()
        
        view = followView
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        viewModel.dismiss?()
    }
    
    override func bind() {
        let viewWillAppearTrigger = self.rx.viewWillAppear
        let viewWillDisAppearTrigger = self.rx.viewWillDisAppear
        
        let input = FollowViewModel.Input(
            viewWillAppearTrigger: viewWillAppearTrigger, 
            viewWillDisAppearTrigger: viewWillDisAppearTrigger
        )
        let _ = viewModel.transform(input: input)
        
        viewModel.peopleList
            .bind(to: followView.collectionView.rx.items(cellIdentifier: FollowCollectionViewCell.identifier, cellType: FollowCollectionViewCell.self)) { [weak self] row, element, cell in
                guard let self else { return }
                
                cell.configureCell(element, followingList: viewModel.temp.value)
                
                cell.followButton.rx.tap
                    .bind(with: self) { owner, _ in
                        owner.viewModel.followButtonTapped.accept(element.userID)
                    }
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
    }
}
