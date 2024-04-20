//
//  BaseViewController.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/13/24.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .customBasic
        bind()
        configureNavigationItem()
    }
    
    func bind() { }
    func configureNavigationItem() { }
}
