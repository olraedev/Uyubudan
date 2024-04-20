//
//  ContentsViewModel.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/21/24.
//

import Foundation
import RxSwift
import RxCocoa

final class ContentsViewModel: ViewModelType {
    
    var disposeBag = DisposeBag()
    
    struct Input {
        let title: ControlProperty<String?>
        let content: ControlProperty<String?>
    }
    
    struct Output {
        let titleValidation: PublishRelay<Bool>
        let contentValidation: PublishRelay<Bool>
    }
    
    func transform(input: Input) -> Output {
        let titleValidation = PublishRelay<Bool>()
        let contentValidation = PublishRelay<Bool>()
        
        input.title.orEmpty.changed
            .map { $0.count > 2 && $0.count <= 30}
            .bind(to: titleValidation)
            .disposed(by: disposeBag)
        
        input.content.orEmpty.changed
            .map { $0.count > 2 && $0.count <= 1000}
            .bind(to: contentValidation)
            .disposed(by: disposeBag)
        
        return Output(
            titleValidation: titleValidation,
            contentValidation: contentValidation
        )
    }
}
