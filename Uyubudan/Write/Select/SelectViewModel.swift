//
//  SelectViewModel.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/21/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SelectViewModel: ViewModelType {
    
    var disposeBag = DisposeBag()
    
    let selectedImage = BehaviorRelay<[Data]>(value: [])
    
    struct Input {
        let leftText: ControlProperty<String?>
        let rightText: ControlProperty<String?>
        let completeButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let validation: Observable<(Bool, Bool)>
        let result: PublishRelay<Result<PostData, HTTPError>>
    }
    
    func transform(input: Input) -> Output {
        let leftValidation = PublishRelay<Bool>()
        let rightValidation = PublishRelay<Bool>()
        let uploadImage = PublishRelay<UploadImageModel>()
        let result = PublishRelay<Result<PostData, HTTPError>>()
        
        input.leftText.orEmpty.changed
            .map { $0.count > 0 }
            .bind(to: leftValidation)
            .disposed(by: disposeBag)
        
        input.rightText.orEmpty.changed
            .map { $0.count > 0 }
            .bind(to: rightValidation)
            .disposed(by: disposeBag)
        
        input.leftText.orEmpty.changed
            .bind(with: self) { owner, text in
                WriteManager.shared.content1 = text
            }
            .disposed(by: disposeBag)
        
        input.rightText.orEmpty.changed
            .bind(with: self) { owner, text in
                WriteManager.shared.content2 = text
            }
            .disposed(by: disposeBag)
        
        input.completeButtonTapped
            .throttle(.milliseconds(500), latest: false, scheduler: MainScheduler.instance)
            .filter { !self.selectedImage.value.isEmpty }
            .flatMap {
                return NetworkManager.uploadImageToServer(datas: self.selectedImage.value)
            }
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let model):
                    print("upload 성공")
                    uploadImage.accept(model)
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        input.completeButtonTapped
            .throttle(.milliseconds(500), latest: false, scheduler: MainScheduler.instance)
            .filter { self.selectedImage.value.isEmpty }
            .map { result in
                let manager = WriteManager.shared
                return WriteQuery(
                    title: manager.title, content: manager.content,
                    content1: manager.content1, content2: manager.content2,
                    content3: manager.content3, productID: manager.productID, files: nil
                )
            }
            .flatMap {
                NetworkManager.fetchToServer(model: PostData.self, router: PostRouter.write(WriteQuery: $0))
            }
            .bind(to: result)
            .disposed(by: disposeBag)
        
        uploadImage
            .map { result in
                let manager = WriteManager.shared
                return WriteQuery(
                    title: manager.title, content: manager.content,
                    content1: manager.content1, content2: manager.content2,
                    content3: manager.content3, productID: manager.productID, files: result.files
                )
            }
            .flatMap {
                NetworkManager.fetchToServer(model: PostData.self, router: PostRouter.write(WriteQuery: $0))
            }
            .bind(to: result)
            .disposed(by: disposeBag)
        
        return Output(
            validation: Observable.combineLatest(leftValidation, rightValidation), 
            result: result
        )
    }
}
