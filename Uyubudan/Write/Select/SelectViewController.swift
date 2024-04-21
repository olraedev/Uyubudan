//
//  SelectViewController.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/21/24.
//

import UIKit
import RxSwift
import RxCocoa

final class SelectViewController: WriteViewController {
    
    private let selectView = SelectView()
    private let viewModel = SelectViewModel()
    
    override func loadView() {
        super.loadView()
        
        view = selectView
    }
    
    override func bind() {
        let leftText = selectView.leftTextField.rx.text
        let rightText = selectView.rightTextField.rx.text
        let completeButtonTapped = selectView.completeButton.rx.tap
        
        let input = SelectViewModel.Input(
            leftText: leftText,
            rightText: rightText, 
            completeButtonTapped: completeButtonTapped
        )
        let output = viewModel.transform(input: input)
        
        let validation = output.validation.map { $0 && $1 }
        
        validation
            .bind(to: selectView.completeButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        validation
            .map { [weak self] state in
                self?.buttonColor(state)
            }
            .bind(to: selectView.completeButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        output.result
            .bind(with: self) { owner, result in
                switch result {
                case .success(_):
                    owner.view.makeToast("포스트 게시 성공!", duration: 1)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        owner.dismiss(animated: true)
                    }
                case .failure(_):
                    owner.showAlert(title: nil, message: "포스트 게시에 실패하였습니다.") {
                        owner.dismiss(animated: true)
                    }
                }
            }
            .disposed(by: disposeBag)
    }
}
