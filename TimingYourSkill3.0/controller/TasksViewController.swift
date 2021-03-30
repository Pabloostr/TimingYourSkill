//
//  ViewController.swift
//  TimingYourSkill3.0
//
//  Created by Pavlo Ostrozhynskyi on 25.03.2021.
//

import UIKit

class  TasksViewController: UIViewController {
    
    @IBOutlet weak var menuSegmentedControl: UISegmentedControl!
    @IBOutlet weak var ongoingTasksConteinerView: UIView!
    @IBOutlet weak var doneTasksConteinerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentedControl()
        
        
    }
    
    private func setupSegmentedControl() {     //настройка menuSegmentedControl
        menuSegmentedControl.removeAllSegments()
        MenuSection.allCases.enumerated().forEach { (index, section) in
            menuSegmentedControl.insertSegment(withTitle: section.rawValue,
                                               at: index,
                                               animated: false)
        }
        menuSegmentedControl.selectedSegmentIndex = 0  // по дефолту буде вибраний "ongoing"
        showConteinerView(for: .ongoing)
    }

    
    @IBAction func segmentedControlChanged(_ sender:UISegmentedControl) {
        switch sender.selectedSegmentIndex { // якщо індекс 0 то показує ongoing ,1 - done
        case 0:
            showConteinerView(for: .ongoing)
        case 1:
            showConteinerView(for: .done)
        default: break
        }
    }
    
    
    private func showConteinerView(for section: MenuSection){ //функція яка вибирає який контейнер буде відображено
        switch section {
        case .ongoing:
            ongoingTasksConteinerView.isHidden = false
            doneTasksConteinerView.isHidden = true
        case .done:
            ongoingTasksConteinerView.isHidden = true
            doneTasksConteinerView.isHidden = false
        
        }
    }
    
    @IBAction func addTaskButtonTapped (_ sender:UIButton){
        performSegue(withIdentifier: "showNewTask", sender: nil)
    }
}

