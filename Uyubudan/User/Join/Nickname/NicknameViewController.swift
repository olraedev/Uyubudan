//
//  NicknameViewController.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/16/24.
//

import UIKit
import RxSwift
import RxCocoa
import Toast

final class NicknameViewController: JoinViewController {
    
    private let nicknameView = NicknameView()
    private let viewModel = NicknameViewModel()
    
    override func loadView() {
        super.loadView()
        
        view = nicknameView
    }
    
    override func bind() {
        let nickname = nicknameView.nickTextField.rx.text
        let completeButtonTapped = nicknameView.completeButton.rx.tap
        
        let input = NicknameViewModel.Input(
            nickname: nickname, 
            completeButtonTapped: completeButtonTapped
        )
        let output = viewModel.transform(input: input)
        
        output.nicknameValidation
            .drive(with: self) { owner, state in
                owner.nicknameView.designViewWithNicknameValidation(state: state)
            }
            .disposed(by: disposeBag)
        
        output.complete
            .drive(with: self) { owner, _ in
                owner.view.makeToast("회원가입이 완료되었습니다.", duration: 1)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    owner.dismiss(animated: true)
                }
            }
            .disposed(by: disposeBag)
        
        output.error
            .drive(with: self) { owner, error in
                owner.showAlert(title: nil, message: error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }
    
    deinit {
        print("Nickname Deinit")
    }
}
