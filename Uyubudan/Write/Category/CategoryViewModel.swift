//
//  CategoryViewModel.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/21/24.
//

import Foundation
import RxSwift
import RxCocoa

final class CategoryViewModel: ViewModelType {
    
    var disposeBag = DisposeBag()
    
    struct Input {
        let categorySelected: ControlEvent<[String]>
    }
    
    struct Output {
        let selected: Driver<Bool>
        let categoryList: Driver<[String]>
    }
    
    func transform(input: Input) -> Output {
        let categoryList = BehaviorSubject(value: ["작명", "메뉴", "쇼핑", "여행", "기타"])
        let selected = BehaviorRelay(value: false)
        
        input.categorySelected
            .map { $0[0] }
            .bind(with: self) { owner, item in
                WriteManager.shared.category = item
                selected.accept(true)
            }
            .disposed(by: disposeBag)
        
        return Output(
            selected: selected.asDriver(),
            categoryList: categoryList.asDriver(onErrorJustReturn: [])
        )
    }
}
