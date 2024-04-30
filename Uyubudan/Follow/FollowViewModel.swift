//
//  FollowViewModel.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/25/24.
//

import Foundation
import RxSwift
import RxCocoa

final class FollowViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    
    var people: [FollowInfo] = []
    var myFollwings: [String] = []
    var followState: FollowState = .follower
    var dismiss: (() -> Void)?
    
    let peopleList = BehaviorRelay<[FollowInfo]>(value: [])
    let followList = BehaviorRelay<[String: Bool]>(value: [:])
    let myFollowingList = BehaviorRelay<[String]>(value: [])
    let temp = BehaviorRelay<[String: Bool]>(value: [:])
    let followButtonTapped = PublishRelay<String>()
    
    struct Input {
        let viewWillAppearTrigger: ControlEvent<Bool>
        let viewWillDisAppearTrigger: ControlEvent<Bool>
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        input.viewWillAppearTrigger
            .bind(with: self) { owner, _ in
                var followList: [String: Bool] = [:]
                var followingList: [String] = []
                
                if owner.followState == .follower {
                    owner.people.forEach { info in
                        followList.updateValue(false, forKey: info.userID)
                    }
                    
                    owner.myFollwings.forEach { info in
                        followingList.append(info)
                    }
                    
                    // 맞팔 체크
                    for (key, _) in followList {
                        if followingList.contains(key) {
                            followList.updateValue(true, forKey: key)
                        }
                    }
                } else {
                    owner.people.forEach { info in
                        followList.updateValue(true, forKey: info.userID)
                    }
                }
                
                owner.peopleList.accept(owner.people)
                owner.followList.accept(followList)
                owner.temp.accept(followList)
            }
            .disposed(by: disposeBag)
        
        followButtonTapped
            .throttle(.milliseconds(500), latest: false, scheduler: MainScheduler.instance)
            .bind(with: self) { owner, userID in
                var list = owner.temp.value
                if let state = list[userID] {
                    list[userID] = !state
                }
                
                owner.temp.accept(list)
                owner.peopleList.accept(owner.peopleList.value)
            }
            .disposed(by: disposeBag)
        
        input.viewWillDisAppearTrigger
            .map { _ in self.checkDiffState() }
            .flatMap { Observable.from($0) }
            .flatMap { 
                NetworkManager.fetchToServer(model: FollowModel.self, router: $0)
            }
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(_):
                    print("follow success")
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        return Output()
    }
    
    private func checkDiffState() -> [FollowRouter] {
        var dict: [FollowRouter] = []
        
        for (key, value) in followList.value {
            if temp.value[key] != value && value == true {
                dict.append(FollowRouter.cancel(userID: key))
            }
            
            if temp.value[key] != value && value == false {
                dict.append(FollowRouter.follow(userID: key))
            }
        }
        
        return dict
    }
}
