//
//  EmailViewController.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/15/24.
//

import UIKit

final class EmailViewController: JoinViewController {
    
    override func configureNavigationItem() {
        super.configureNavigationItem()
        
        navigationItem.leftBarButtonItem?.isHidden = true
    }
}
