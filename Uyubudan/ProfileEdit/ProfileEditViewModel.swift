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
    
    init() {
        
    }
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
}
