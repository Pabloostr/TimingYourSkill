//
//  LoadingViewController.swift
//  TimingYourSkill3.0
//
//  Created by Pavlo Ostrozhynskyi on 20.04.2021.
//

import UIKit

class LoadingViewController: UIViewController {
    
    private let authManager = AuthManager()
    private let navigationManager = NavigationManager.shared
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showInitialScreen()
    }
    
    func showInitialScreen(){
        if authManager.isUserLoggedIn() {
            navigationManager.show(scene: .tasks)
        }else {
            navigationManager.show(scene: .onboarding)
        }
    }
    
    
}
