//
//  CommentsViewModel.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/21/24.
//

import Foundation
import RxSwift
import RxCocoa

final class CommentsViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    
    var postInfo: PostData!
    
    struct Input {
        let viewDidLoadTrigger: ControlEvent<Bool>
    }
    
    struct Output {
        let comments: Driver<[Comment]>
    }
    
    func transform(input: Input) -> Output {
        let comments = PublishRelay<[Comment]>()
        
        input.viewDidLoadTrigger
            .bind(with: self) { owner, _ in
                comments.accept(owner.postInfo.comments)
            }
            .disposed(by: disposeBag)
        
        return Output(
            comments: comments.asDriver(onErrorJustReturn: [])
        )
    }
}
