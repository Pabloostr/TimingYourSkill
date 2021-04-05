//
//  ViewController.swift
//  TimingYourSkill3.0
//
//  Created by Pavlo Ostrozhynskyi on 25.03.2021.
//

import UIKit

class  TasksViewController: UIViewController, Animatable {
    
    @IBOutlet weak var menuSegmentedControl: UISegmentedControl!
    @IBOutlet weak var ongoingTasksConteinerView: UIView!
    @IBOutlet weak var doneTasksConteinerView: UIView!
    
    private let  databaseManager = DatabaseManager()
    
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
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNewTask",
           let destination = segue.destination as? NewTaskViewController {
            destination.delegate = self
        } else if segue.identifier == "showOngoingTasks"{
            let destination = segue.destination as? OngoingTasksTableViewController
            destination?.delegate = self
        }
        
    }
    
    private func deleteTask(id:String) {
        databaseManager.deleteTask(id: id) { [weak self] (result) in
            switch result {
            case.success:
                self?.showToast(state: .success, message: "Task deleted succsessfully")
            case.failure(let error):
                self?.showToast(state: .error, message: error.localizedDescription)
            }
        }
    }
    
    @IBAction func addTaskButtonTapped (_ sender:UIButton){
        performSegue(withIdentifier: "showNewTask", sender: nil)
    }
}


extension TasksViewController: OngoingTaskTVCDelegate {
        func showOptions (for task: Task) { /// алерт який показує кнопки для видалення таски
        let alertController = UIAlertController (title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [unowned self] _ in
            guard let id = task.id else {return}
            self.deleteTask(id: id)
            
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension TasksViewController: TasksVCDelegate { // додавання таски в firebase
    func didAddTask(_ task: Task) {
        
        presentedViewController?.dismiss(animated: true, completion: { [unowned self] in
            self.databaseManager.addTask(task) { (result ) in
                switch result {
                case .success:
                    print("yay")
                case .failure(let error):
                    print("error:  \(error.localizedDescription)")
                }
            }
        })
        
    }
    
    
}
