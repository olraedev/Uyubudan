//
//  SelectViewController.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/21/24.
//

import UIKit
import RxSwift
import RxCocoa
import PhotosUI

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
        
        selectView.uploadButton.rx.tap
            .bind(with: self) { owner, _ in
                var configuration = PHPickerConfiguration()
                configuration.selectionLimit = 2
                configuration.selection = .ordered
                configuration.filter =  .images
                let picker = PHPickerViewController(configuration: configuration)
                picker.delegate = self
                
                owner.present(picker, animated: true)
            }
            .disposed(by: disposeBag)
    }
}

extension SelectViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        var dict: [Int: Data] = [:]
        var images: [Data] = []
        let group = DispatchGroup()
        let imageViews = [selectView.leftImageView, selectView.rightImageView]
        
        for idx in 0..<results.count {
            group.enter()
            let result = results[idx].itemProvider
            if result.canLoadObject(ofClass: UIImage.self) {
                result.loadObject(ofClass: UIImage.self) { image, error in
                    defer { group.leave() }
                    
                    DispatchQueue.main.async {
                        imageViews[idx].image = image as? UIImage
                        
                        guard let imageViewsImage = imageViews[idx].image?.resizeWithWidth(width: 700)?.pngData() else {
                            return
                        }
                        dict.updateValue(imageViewsImage, forKey: idx)
                        // images.append(imageViewsImage)
                    }
                }
            }
        }
        
        group.notify(queue: .main) {
            dict.sorted { $0.0 < $1.0 }.forEach { result in
                images.append(result.value)
            }
            
            self.viewModel.selectedImage.accept(images)
        }
    }
}
