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
    
    override func loadView() {
        super.loadView()
        
        view = homeView
    }
    
    override func bind() {
        let a = Observable.just([1, 2])
        
        a.bind(to: homeView.collectionView.rx.items(cellIdentifier: PostCollectionViewCell.identifier, cellType: PostCollectionViewCell.self)) { row, element, cell in
            print(row)
        }
        .disposed(by: disposeBag)
    }
    
    override func configureNavigationItem() {
        let myPage = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .plain, target: self, action: #selector(myPageBarButtonClicked))
        myPage.tintColor = .customPrimary
        navigationItem.rightBarButtonItem = myPage
    }
}

extension HomeViewController {
    @objc func myPageBarButtonClicked() {
        
    }
}
