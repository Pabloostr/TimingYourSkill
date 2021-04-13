//
//  Extension+Date.swift
//  TimingYourSkill3.0
//
//  Created by Pavlo Ostrozhynskyi on 13.04.2021.
//

import Foundation


extension Date {
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM, d, yyyy"
        return formatter.string(from: self)
    }
     
}
