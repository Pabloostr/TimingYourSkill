//
//  CalendarView.swift
//  TimingYourSkill3.0
//
//  Created by Pavlo Ostrozhynskyi on 12.04.2021.
//

import UIKit
import FSCalendar

class CalendarView: UIView {
    private lazy var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [calendar])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo:  topAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo:  leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo:  trailingAnchor, constant: -24),
            stackView.bottomAnchor.constraint(equalTo:  bottomAnchor, constant: -24),
            calendar.heightAnchor.constraint(equalToConstant: 240)
            
        ])
    }
}

