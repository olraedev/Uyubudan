//
//  ProfileEditViewModel.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/23/24.
//

import Foundation
import RxSwift
import RxCocoa

final class ProfileEditViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    
    var profileInfo = PublishRelay<ProfileModel>()
    let profileImage = PublishRelay<Data>()
    
    struct Input {
        let nickname: ControlProperty<String?>
        let completeButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let nicknameValidation: Driver<Bool>
        let editSuccess: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        let nicknameValidation = BehaviorRelay(value: true)
        let editSuccess = PublishRelay<Bool>()
        
        input.nickname.orEmpty.changed
            .map { 2 <= $0.count && $0.count < 10 }
            .bind(to: nicknameValidation)
            .disposed(by: disposeBag)
        
        input.completeButtonTapped
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .withLatestFrom(Observable.combineLatest(input.nickname.orEmpty, profileImage))
            .flatMap {
                NetworkManager.multipartToServer(model: ProfileModel.self, router: ProfileRouter.update, datas: ["profile": [$0.1]], body: ["nick": $0.0])
            }
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let model):
                    UserDefaultsManager.shared.profileImage = model.profileImage
                    editSuccess.accept(true)
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(
            nicknameValidation: nicknameValidation.asDriver(onErrorJustReturn: false), 
            editSuccess: editSuccess.asDriver(onErrorJustReturn: false)
        )
    }
}
