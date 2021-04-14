//
//  Extension+Date.swift
//  TimingYourSkill3.0
//
//  Created by Pavlo Ostrozhynskyi on 13.04.2021.
//

import Foundation


extension Date {
    
    func toString() -> String { /// дата в створенні таски тепер записана як день\місяць\число
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM, d, yyyy"
        return formatter.string(from: self)
    }
     
    func toRelativeString() -> String { /// в самій тасці тепер показано скількі днів лишилось до дедлайна таски
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        let today = Date()
        return formatter.localizedString(for: self, relativeTo: today)
    }
    
    func isOverDue() -> Bool {
        let today = Date()
        return self < today
    }
}
