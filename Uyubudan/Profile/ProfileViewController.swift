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
    
    private let mypageView = ProfileView()
    let viewModel = ProfileViewModel()
    
    override func loadView() {
        super.loadView()
        
        view = mypageView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.viewWillAppearTrigger.accept(())
    }
    
    override func bind() {
        let segmentChanged = mypageView.segment.rx.selectedSegmentIndex
        let input = ProfileViewModel.Input(
            segmentChanged: segmentChanged
        )
        let output = viewModel.transform(input: input)
        
        viewModel.profileInfo
            .bind(with: self) { owner, result in
                owner.mypageView.configureViews(result)
            }
            .disposed(by: disposeBag)
        
        output.posts
            .drive(mypageView.collectionView.rx
                .items(cellIdentifier: CardCollectionViewCell.identifier, cellType: CardCollectionViewCell.self)) { row, element, cell in
                    cell.configureCell(element)
                }
                .disposed(by: disposeBag)
        
        mypageView.segment.rx.selectedSegmentIndex
            .bind(with: self) { owner, _ in
                owner.mypageView.changeUnderLineView()
            }
            .disposed(by: disposeBag)
        
        mypageView.editBarButtonItem.rx.tap
            .withLatestFrom(viewModel.profileInfo)
            .bind(with: self) { owner, model in
                let vc = ProfileEditViewController()
                vc.viewModel.profileInfo.accept(model)
                owner.navigationController?.pushViewController(vc, animated: true)
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
        
        mypageView.followersButton.rx.tap
            .withLatestFrom(self.viewModel.profileInfo)
            .bind(with: self) { owner, profile in
                let vc = FollowViewController()
                vc.viewModel.people = profile.followers
                vc.viewModel.myFollwings = owner.viewModel.myFollowingList.value
                vc.viewModel.followState = .follower
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
            .disposed(by: disposeBag)
        
        mypageView.followingButton.rx.tap
            .withLatestFrom(self.viewModel.profileInfo)
            .bind(with: self) { owner, profile in
                let vc = FollowViewController()
                vc.viewModel.people = profile.following
                vc.viewModel.myFollwings = owner.viewModel.myFollowingList.value
                vc.viewModel.followState = .following
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
            .disposed(by: disposeBag)
        
        mypageView.dismissButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureNavigationItem() {
        navigationItem.leftBarButtonItem = mypageView.dismissButton
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
        
        if viewModel.profileState == .mine {
            let logout = UIAction(title: "로그아웃") { [weak self] _ in
                self?.logoutButtonClicked()
            }
            let withdraw = UIAction(title: "회원탈퇴", attributes: .destructive) { [weak self] _ in
                self?.withdrawButtonClicked()
            }
            mypageView.settingBarButtonItem.menu = UIMenu(children: [logout, withdraw])
            navigationItem.rightBarButtonItems = [mypageView.settingBarButtonItem, mypageView.editBarButtonItem]
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
