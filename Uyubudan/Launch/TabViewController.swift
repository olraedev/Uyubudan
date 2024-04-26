//
//  TabViewController.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/21/24.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        let home = UINavigationController(rootViewController: HomeViewController())
        let write = CategoryViewController()
        let myProfile = UINavigationController(rootViewController: ProfileViewController())
        
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .customPrimary
        self.tabBar.unselectedItemTintColor = .lightGray
        
        home.tabBarItem = UITabBarItem(title: "피드", image: UIImage(systemName: "doc.append"), tag: 0)
        write.tabBarItem = UITabBarItem(title: "작성", image: UIImage(systemName: "plus.app"), tag: 1)
        myProfile.tabBarItem = UITabBarItem(title: "마이", image: UIImage(systemName: "person.fill"), tag: 2)
        
        self.setViewControllers([home, write, myProfile], animated: true)
    }
}

extension TabViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is CategoryViewController {
            let vc = UINavigationController(rootViewController: CategoryViewController())
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
            return false
        }
        return true
    }
}
