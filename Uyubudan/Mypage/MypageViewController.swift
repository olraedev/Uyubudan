//
//  MypageViewController.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/22/24.
//

import UIKit
import RxSwift
import RxCocoa

final class MypageViewController: BaseViewController {
    
    private let mypageView = MypageView()
    private let viewModel = MypageViewModel()
    
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
        let input = MypageViewModel.Input(
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
    }
    
    override func configureNavigationItem() {
        navigationItem.rightBarButtonItems = [mypageView.settingBarButtonItem, mypageView.editBarButtonItem]
    }
}
