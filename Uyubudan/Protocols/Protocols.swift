//
//  Protocols.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/15/24.
//

import Foundation
import RxSwift

protocol ViewModelType {
    var disposeBag: DisposeBag { get }
    
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
