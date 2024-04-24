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
                let text = state ? "사용 가능한 닉네임입니다." : "2글자 이상 10글자 미만으로 입력해주세요."
                
                owner.nicknameView.validationLabel.text = text
                owner.nicknameView.validationLabel.textColor = state.textColor
                
                owner.nicknameView.completeButton.isEnabled = state
                owner.nicknameView.completeButton.backgroundColor = state.buttonColor
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
            .drive(with: self) { owner, text in
                owner.showAlert(title: nil, message: text)
            }
            .disposed(by: disposeBag)
    }
}
