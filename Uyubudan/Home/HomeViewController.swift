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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.viewWillAppearTrigger.accept(())
    }
    
    override func bind() {
        viewModel.categories
            .bind(to: homeView.categoryCollectionView.rx.items(cellIdentifier: CategoryCollectionViewCell.identifier, cellType: CategoryCollectionViewCell.self)) { [weak self] row, element, cell in
                guard let self else { return }
                
                cell.configureCell(title: element, nowCategory: self.viewModel.categoryClicked.value)
                cell.button.rx.tap
                    .map { return element }
                    .bind(to: self.viewModel.categoryClicked)
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        viewModel.categoryPostList
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
        
        Observable.zip(homeView.collectionView.rx.itemSelected, homeView.collectionView.rx.modelSelected(PostData.self))
            .subscribe(with: self) { owner, _ in
                print("adfafsf")
            }
            .disposed(by: disposeBag)
    }
    
    override func configureNavigationItem() {
        let profileImageView = ProfileImageView(frame: .zero)
        profileImageView.setImage(url: UserDefaultsManager.shared.profileImage)
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(myPageBarButtonClicked)))
        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(30)
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileImageView)
        navigationItem.title = "우유부단"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension HomeViewController {
    @objc func myPageBarButtonClicked() {
        print(#function)
    }
}
