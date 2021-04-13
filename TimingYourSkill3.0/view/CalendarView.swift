//
//  CalendarView.swift
//  TimingYourSkill3.0
//
//  Created by Pavlo Ostrozhynskyi on 12.04.2021.
//

import UIKit
import FSCalendar

class CalendarView: UIView { /// настройки календаря
    private lazy var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.delegate = self
        return calendar
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Select deadline"
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var removeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Remove ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.addTarget(self, action: #selector(removeButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel,  calendar, removeButton])
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
            calendar.heightAnchor.constraint(equalToConstant: 240),
            titleLabel.heightAnchor.constraint(equalToConstant: 24),
            removeButton.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
    
    @objc func removeButtonTapped(_ sender: UIButton) {
        print("remove button tapped")
    }
}

extension CalendarView: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("date selected \(date)")
    }
}
