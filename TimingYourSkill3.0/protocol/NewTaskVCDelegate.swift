//
//  TasksVCDelegate.swift
//  TimingYourSkill3.0
//
//  Created by Pavlo Ostrozhynskyi on 30.03.2021.
//

import Foundation

protocol NewTaskVCDelegate: class {
    func didAddTask(_ task: Task)
    func didEditTask(_ task: Task) 
}
