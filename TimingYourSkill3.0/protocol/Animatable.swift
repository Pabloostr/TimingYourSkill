//
//  Animatable.swift
//  TimingYourSkill3.0
//
//  Created by Pavlo Ostrozhynskyi on 01.04.2021.
//

import Loaf
import Foundation
import MBProgressHUD

protocol Animatable {
    
    
}

extension Animatable where Self: UIViewController{ /// настрйки вспливаючого вікна (анімації)
    
    func  showLoadingAnimation() {
        DispatchQueue.main.async {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.backgroundColor = UIColor.init(white: 0.5, alpha: 0.3)
        }
    }
    
    func hideLoadingAnimation() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func showToast(state: Loaf.State, message: String, location: Loaf.Location = .top, duration: TimeInterval = 1.0) {
        DispatchQueue.main.async {
            Loaf.init(message,
                      state: state,
                      location: location,
                      sender: self).show(.custom(duration))
        }
    }
    
    
}
