//
//  LaunchViewController.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/20/24.
//

import UIKit

final class LaunchViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        var nav: UIViewController
        
        // 현재 저장된 accessToken이 없는 경우 -> 로그인
        if UserDefaultsManager.shared.accessToken == "" {
            nav = LoginViewController()
        }
        // 아니면 홈 화면으로
        else {
            nav = TabViewController()
        }
        
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    override func bind() {
        super.bind()
    }
}
