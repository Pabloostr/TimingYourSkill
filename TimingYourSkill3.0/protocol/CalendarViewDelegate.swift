//
//  CalendarViewDelegate.swift
//  TimingYourSkill3.0
//
//  Created by Pavlo Ostrozhynskyi on 13.04.2021.
//

import Foundation


protocol CalendarViewDelegate: class {
    func calendarViewDidSelectDate(date: Date)
    func calendarDidTapCloseButton()
}
