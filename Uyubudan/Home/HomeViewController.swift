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
        homeView.profileImageView.setImage(url: UserDefaultsManager.shared.profileImage)
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
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
                    cell.configureCell(element, myFollowingList: self.viewModel.myFollowingList.value)
                    
                    cell.deleteButton.rx.tap
                        .bind(with: self) { owner, _ in
                            owner.showAlert(title: nil, message: "정말 삭제하시겠습니까?") {
                                owner.viewModel.deleteButtonClicked.accept(element)
                            }
                        }
                        .disposed(by: cell.disposeBag)
                    
                    cell.leftButton.rx.tap
                        .bind(with: self, onNext: { owner, _ in
                            owner.viewModel.leftButtonClicked.accept(row)
                        })
                        .disposed(by: cell.disposeBag)
                    
                    cell.rightButton.rx.tap
                        .bind(with: self) { owner, _ in
                            owner.viewModel.rightButtonClicked.accept(row)
                        }
                        .disposed(by: cell.disposeBag)
                    
                    cell.commentsCountButton.rx.tap
                        .bind(with: self) { owner, _ in
                            let vc = CommentsViewController()
                            vc.viewModel.postID = element.postID
                            vc.viewModel.dismiss = {
                                self.viewModel.viewWillAppearTrigger.accept(())
                            }
                            if let sheet = vc.sheetPresentationController {
                                sheet.detents = [.medium(), .large()]
                                sheet.prefersScrollingExpandsWhenScrolledToEdge = true
                                sheet.prefersGrabberVisible = true
                                sheet.preferredCornerRadius = 30
                            }
                            owner.present(vc, animated: true)
                        }
                        .disposed(by: cell.disposeBag)
                    
                    cell.profileView.followButton.rx.tap
                        .bind(with: self) { owner, _ in
                            owner.viewModel.followButtonClicked.accept(element)
                        }
                        .disposed(by: cell.disposeBag)
                    
                    cell.tapGesture.rx.event
                        .bind(with: self) { owner, _ in
                            if element.creator.userID == UserDefaultsManager.shared.userID {
                                owner.tabBarController?.selectedIndex = 2
                            } else {
                                let vc = ProfileViewController()
                                vc.viewModel.profileState = .other
                                vc.viewModel.userID = element.creator.userID
                                
                                owner.navigationController?.pushViewController(vc, animated: true)
                            }
                        }
                        .disposed(by: cell.disposeBag)
                }
                .disposed(by: disposeBag)
        
        homeView.refreshControl.rx.controlEvent(.valueChanged)
            .bind(with: self) { owner, _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    owner.viewModel.viewWillAppearTrigger.accept(())
                    owner.homeView.refreshControl.endRefreshing()
                }
            }
            .disposed(by: disposeBag)
    }
    
    override func configureNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: homeView.profileImageView)
        navigationItem.title = "우유부단🐮"
    }
}

extension HomeViewController {
    @objc func myPageBarButtonClicked() {
        print(#function)
    }
}
