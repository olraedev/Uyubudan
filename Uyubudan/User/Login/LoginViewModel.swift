//
//  LoginViewModel.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/16/24.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel: ViewModelType {
    
    var disposeBag = DisposeBag()
    
    struct Input {
        let email: ControlProperty<String?>
        let password: ControlProperty<String?>
        let loginButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let success: Driver<String>
        let errorInfo: Driver<HTTPError>
    }
    
    func transform(input: Input) -> Output {
        let success = PublishRelay<String>()
        let errorInfo = PublishRelay<HTTPError>()
        let login = Observable.combineLatest(input.email.orEmpty, input.password.orEmpty)
            .map { email, password in
                return LoginQuery(email: email, password: password)
            }
        
        input.loginButtonTapped
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(login)
            .flatMap {
                NetworkManager.fetchToServer(model: LoginModel.self, router: UserRouter.login(LoginQuery: $0))
            }
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let model):
                    owner.configureUserDefaults(model)
                    success.accept(model.nickName)
                case .failure(let error):
                    errorInfo.accept(error)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(
            success: success.asDriver(onErrorJustReturn: ""),
            errorInfo: errorInfo.asDriver(onErrorJustReturn: .serverError)
        )
    }
}

extension LoginViewModel {
    private func configureUserDefaults(_ model: LoginModel) {
        UserDefaultsManager.userID = model.userID
        UserDefaultsManager.accessToken = model.accessToken
        UserDefaultsManager.refreshToken = model.refreshToken
        UserDefaultsManager.profileImage = model.profileImage
    }
}
