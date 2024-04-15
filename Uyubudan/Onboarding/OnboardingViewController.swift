//
//  OnboardingViewController.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/15/24.
//

import Foundation

final class OnboardingViewController: BaseViewController {
    
    private let onboardingView = OnboardingView()
    
    override func loadView() {
        super.loadView()
        
        view = onboardingView
    }
}
