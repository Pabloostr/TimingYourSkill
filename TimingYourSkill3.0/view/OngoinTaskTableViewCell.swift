//
//  OngoinTaskTableViewCell.swift
//  TimingYourSkill3.0
//
//  Created by Pavlo Ostrozhynskyi on 30.03.2021.
//

import UIKit

class OngoinTaskTableViewCell: UITableViewCell {
    
    var actionButtonDidTap: (() -> Void)?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    
    func configure(with task: Task) {
        titleLabel.text = task.title
        deadlineLabel.text = task.deadline?.toRelativeString()
        
        if task.deadline?.isOverDue() == true {
            deadlineLabel.textColor = .red
            deadlineLabel.font = UIFont(name: "AvenirNext-Medium", size: 12)
        }
    }
    
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        actionButtonDidTap?()
    }
    
    
}
