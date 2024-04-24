//
//  ProfileEditViewController.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/23/24.
//

import UIKit
import RxSwift
import RxCocoa
import PhotosUI

final class ProfileEditViewController: BaseViewController {
    
    private let profileEditView = ProfileEditView()
    let viewModel: ProfileEditViewModel
    
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
        let nickname = profileEditView.nickTextField.rx.text
        let completeButtonTapped = profileEditView.completeButton.rx.tap
        
        let input = ProfileEditViewModel.Input(
            nickname: nickname,
            completeButtonTapped: completeButtonTapped
        )
        let output = viewModel.transform(input: input)
        
        profileEditView.imageEditButton.rx.tap
            .bind(with: self) { owner, _ in
                let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                let delete = UIAlertAction(title: "삭제하기", style: .destructive) { _ in
                    owner.profileEditView.profileImageView.setImage(url: Environment.defaultImage)
                    
                    guard let profileImage = owner.profileEditView.profileImageView.image?.pngData() else {
                        return
                    }
                    owner.viewModel.profileImage.accept(profileImage)
                }
                let loadImage = UIAlertAction(title: "불러오기", style: .default) { _ in
                    var configuration = PHPickerConfiguration()
                    configuration.selectionLimit = 1
                    configuration.filter =  .images
                    let picker = PHPickerViewController(configuration: configuration)
                    picker.delegate = self
                    
                    owner.present(picker, animated: true)
                }
                let cancel = UIAlertAction(title: "취소", style: .cancel)
                
                sheet.addAction(delete)
                sheet.addAction(loadImage)
                sheet.addAction(cancel)
                
                owner.present(sheet, animated: true)
            }
            .disposed(by: disposeBag)
        
        output.nicknameValidation
            .drive(with: self) { owner, state in
                let text = state ? "사용 가능한 닉네임입니다." : "2글자 이상 10글자 미만으로 입력해주세요."
                
                owner.profileEditView.validationLabel.text = text
                owner.profileEditView.validationLabel.textColor = state.textColor
                
                owner.profileEditView.completeButton.isEnabled = state
                owner.profileEditView.completeButton.backgroundColor = state.buttonColor
            }
            .disposed(by: disposeBag)
        
        output.editSuccess
            .drive(with: self) { owner, state in
                if state {
                    owner.navigationController?.popViewController(animated: true)
                }
            }
            .disposed(by: disposeBag)
        
        profileEditView.popButtonItem.rx.tap
            .bind(with: self) { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureNavigationItem() {
        navigationItem.leftBarButtonItem = profileEditView.popButtonItem
    }
}

extension ProfileEditViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.async {
                    self?.profileEditView.profileImageView.image = image as? UIImage
                    
                    guard let profileImage = self?.profileEditView.profileImageView.image?.pngData() else {
                        return
                    }
                    self?.viewModel.profileImage.accept(profileImage)
                }
            }
        }
    }
}
