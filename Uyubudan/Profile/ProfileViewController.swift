//
//  MypageViewController.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/22/24.
//

import UIKit
import RxSwift
import RxCocoa

final class ProfileViewController: BaseViewController {
    
    private let profileView = ProfileView()
    let viewModel = ProfileViewModel()
    
    override func loadView() {
        super.loadView()
        
        view = profileView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.viewWillAppearTrigger.accept(())
    }
    
    override func bind() {
        let segmentChanged = profileView.segment.rx.selectedSegmentIndex
        let input = ProfileViewModel.Input(
            segmentChanged: segmentChanged
        )
        let output = viewModel.transform(input: input)
        
        viewModel.profileInfo
            .bind(with: self) { owner, result in
                owner.profileView.configureViews(result)
            }
            .disposed(by: disposeBag)
        
        output.posts
            .drive(profileView.collectionView.rx
                .items(cellIdentifier: CardCollectionViewCell.identifier, cellType: CardCollectionViewCell.self)) { row, element, cell in
                    cell.configureCell(element)
                }
                .disposed(by: disposeBag)
        
        profileView.segment.rx.selectedSegmentIndex
            .bind(with: self) { owner, _ in
                owner.profileView.changeUnderLineView()
            }
            .disposed(by: disposeBag)
        
        profileView.editBarButtonItem.rx.tap
            .withLatestFrom(viewModel.profileInfo)
            .bind(with: self) { owner, model in
                let vc = ProfileEditViewController()
                vc.viewModel.profileInfo.accept(model)
                owner.pushNavigation(vc)
            }
            .disposed(by: disposeBag)
        
        output.successWithdraw
            .drive(with: self) { owner, state in
                if state {
                    owner.showAlert(title: nil, message: "정말 탈퇴를 하시겠습니까?") {
                        owner.logoutButtonClicked()
                    }
                }
            }
            .disposed(by: disposeBag)
        
        profileView.followersButton.rx.tap
            .withLatestFrom(self.viewModel.profileInfo)
            .bind(with: self) { owner, profile in
                let vc = FollowViewController()
                vc.viewModel.people = profile.followers
                vc.viewModel.myFollwings = owner.viewModel.myFollowingList.value
                vc.viewModel.followState = .follower
                vc.viewModel.dismiss = {
                    self.viewModel.viewWillAppearTrigger.accept(())
                }
                owner.presentBottomSheet(vc)
            }
            .disposed(by: disposeBag)
        
        profileView.followingButton.rx.tap
            .withLatestFrom(self.viewModel.profileInfo)
            .bind(with: self) { owner, profile in
                let vc = FollowViewController()
                vc.viewModel.people = profile.following
                vc.viewModel.myFollwings = owner.viewModel.myFollowingList.value
                vc.viewModel.followState = .following
                vc.viewModel.dismiss = {
                    self.viewModel.viewWillAppearTrigger.accept(())
                }
                owner.presentBottomSheet(vc)
            }
            .disposed(by: disposeBag)
        
        profileView.dismissButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        output.errorMessage
            .drive(with: self) { owner, error in
                owner.showAlert(title: nil, message: error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureNavigationItem() {
        navigationItem.leftBarButtonItem = profileView.dismissButton
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
        
        if viewModel.profileState == .mine {
            let logout = UIAction(title: "로그아웃") { [weak self] _ in
                self?.logoutButtonClicked()
            }
            let withdraw = UIAction(title: "회원탈퇴", attributes: .destructive) { [weak self] _ in
                self?.withdrawButtonClicked()
            }
            profileView.settingBarButtonItem.menu = UIMenu(children: [logout, withdraw])
            navigationItem.rightBarButtonItems = [profileView.settingBarButtonItem, profileView.editBarButtonItem]
            navigationItem.leftBarButtonItem?.isHidden = true
        }
    }
}

extension ProfileViewController {
    @objc func logoutButtonClicked() {
        UserDefaultsManager.removeAll()
        
        navigationController?.pushViewController(LaunchViewController(), animated: true)
    }
    
    @objc func withdrawButtonClicked() {
        viewModel.withdrawButtonTapped.accept(())
    }
}
