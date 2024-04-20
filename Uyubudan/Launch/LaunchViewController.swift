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
        var nav: UINavigationController
        
        // 현재 저장된 accessToken이 없는 경우 -> 로그인
        if UserDefaultsManager.shared.accessToken == "" {
            nav = UINavigationController(rootViewController: LoginViewController())
        }
        // 아니면 홈 화면으로
        else {
            nav = UINavigationController(rootViewController: HomeViewController())
        }
        
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}
