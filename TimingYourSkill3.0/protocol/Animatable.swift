//
//  Animatable.swift
//  TimingYourSkill3.0
//
//  Created by Pavlo Ostrozhynskyi on 01.04.2021.
//

import Loaf
import Foundation

protocol Animatable {
    
    
}

extension Animatable where Self: UIViewController{ /// настрйки вспливаючого вікна (анімації)
    
    
    
    func showToast(state: Loaf.State, message: String, location: Loaf.Location = .top, duration: TimeInterval = 1.0) {
        DispatchQueue.main.async {
            Loaf.init(message,
                      state: .info,
                      location: location,
                      sender: self).show(.custom(duration))
        }
    }
    
    
}
