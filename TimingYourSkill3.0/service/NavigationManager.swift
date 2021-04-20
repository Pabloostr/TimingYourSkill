//
//  NavigationManager.swift
//  TimingYourSkill3.0
//
//  Created by Pavlo Ostrozhynskyi on 20.04.2021.
//

import UIKit

class NavigationManager {
    
    
    static let shared = NavigationManager()
    
    private init() {}
    
    enum Scene {
        case onboarding
        case tasks
    }
    
    func show(scene: Scene) {
        switch scene {
        case .onboarding: break
        case .tasks:
            let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TasksNavigationController")
            
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window else {return}
            
            window.rootViewController = navigationController
            
            UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: {}, completion: nil)
        }
    }
    
    
}
