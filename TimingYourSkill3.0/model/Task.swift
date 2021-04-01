//
//  Task.swift
//  TimingYourSkill3.0
//
//  Created by Pavlo Ostrozhynskyi on 30.03.2021.
//

import Foundation
import FirebaseFirestoreSwift

struct Task: Identifiable, Codable {
    
    @DocumentID var id: String?
    @ServerTimestamp var createdAt: Date?
    let title: String
    var isDone: Bool = false
    var doneAt: Date?
}
