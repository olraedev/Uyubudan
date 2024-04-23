//
//  ProfileEditViewController.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/23/24.
//

import UIKit
import RxSwift
import RxCocoa

final class ProfileEditViewController: BaseViewController {
    
    private let profileEditView = ProfileEditView()
    var viewModel: ProfileEditViewModel
    
    override func loadView() {
        super.loadView()
        
        view = profileEditView
    }
    
    init() {
        viewModel = ProfileEditViewModel()
        super.init(nibName: nil, bundle: nil)
        
        viewModel.profileInfo
            .bind(with: self) { owner, model in
                owner.profileEditView.configureView(model)
            }
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func bind() {
        
    }
}
