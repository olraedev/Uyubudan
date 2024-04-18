//
//  HomeViewController.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/13/24.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: BaseViewController {
    
    private let homeView = HomeView()
    private let viewModel = HomeViewModel()
    
    override func loadView() {
        super.loadView()
        
        view = homeView
    }
    
    override func bind() {
        let viewWillAppearTrigger = self.rx.viewWillAppear
        
        let input = HomeViewModel.Input(
            viewWillAppearTrigger: viewWillAppearTrigger
        )
        let output = viewModel.transform(input: input)
        
        output.allPostList.drive(homeView.collectionView.rx.items(
            cellIdentifier: PostCollectionViewCell.identifier,
            cellType: PostCollectionViewCell.self)) { row, element, cell in
                cell.configureCell(element)
        }
        .disposed(by: disposeBag)
    }
    
    override func configureNavigationItem() {
        let myPage = UIBarButtonItem(customView: ProfileImageView(frame: .zero))
        myPage.target = self
        myPage.action = #selector(myPageBarButtonClicked)
        myPage.tintColor = .customPrimary
        navigationItem.rightBarButtonItem = myPage
    }
}

extension HomeViewController {
    @objc func myPageBarButtonClicked() {
        
    }
}
