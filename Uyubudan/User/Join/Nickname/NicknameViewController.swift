//
//  NicknameViewController.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/16/24.
//

import Foundation

final class NicknameViewController: JoinViewController {
    
    private let nicknameView = NicknameView()
    
    override func loadView() {
        super.loadView()
        
        view = nicknameView
    }
}
