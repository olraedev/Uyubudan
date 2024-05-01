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
    
    var postID: String!
    
    let viewWillAppearTrigger = PublishRelay<Void>()
    let deleteButtonTapped = PublishRelay<Comment>()
    var dismiss: (() -> Void)?
    
    struct Input {
        let comment: ControlProperty<String?>
        let completeButton: ControlEvent<Void>
    }
    
    struct Output {
        let comments: Driver<[Comment]>
    }
    
    func transform(input: Input) -> Output {
        let comments = PublishRelay<[Comment]>()
        
        viewWillAppearTrigger
            .map { _ in self.postID }
            .flatMap {
                NetworkManager.fetchToServer(model: PostData.self, router: PostRouter.readSpecific(postID: $0))
            }
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let data):
                    comments.accept(data.comments)
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        // 댓글 작성
        input.completeButton
            .withLatestFrom(input.comment.orEmpty)
            .distinctUntilChanged()
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .map { CommentsWriteQuery(content: $0) }
            .flatMap {
                NetworkManager.fetchToServer(model: Comment.self, router: CommentsRouter.write(postID: self.postID, CommentsWriteQuery: $0))
            }
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(_):
                    owner.viewWillAppearTrigger.accept(())
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        // 댓글 삭제
        deleteButtonTapped
            .flatMap {
                NetworkManager.fetchToServerNoModel(router: CommentsRouter.delete(postID: self.postID, commentID: $0.commentID))
            }
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(_):
                    owner.viewWillAppearTrigger.accept(())
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(
            comments: comments.asDriver(onErrorJustReturn: [])
        )
    }
}
