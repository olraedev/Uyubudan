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
        viewModel.viewWillAppearTrigger.accept(())
        
        viewModel.allPostList
            .bind(to: homeView.collectionView.rx.items(
            cellIdentifier: PostCollectionViewCell.identifier,
            cellType: PostCollectionViewCell.self)) { [weak self] row, element, cell in
                guard let self else { return }
                
                cell.configureCell(element)
                
                cell.leftButton.rx.tap
                    .map { return element }
                    .bind(with: self, onNext: { owner, data in
                        owner.viewModel.leftButtonClicked.accept(data)
                    })
                    .disposed(by: cell.disposeBag)
                
                cell.rightButton.rx.tap
                    .map { return element }
                    .bind(with: self) { owner, data in
                        owner.viewModel.rightButtonClicked
                            .accept(data)
                    }
                    .disposed(by: cell.disposeBag)
        }
        .disposed(by: disposeBag)
    }
    
    override func configureNavigationItem() {
        let profileImageView = ProfileImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        profileImageView.setImage(url: UserDefaultsManager.shared.profileImage)
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(myPageBarButtonClicked)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
}

extension HomeViewController {
    @objc func myPageBarButtonClicked() {
        print(#function)
    }
}
