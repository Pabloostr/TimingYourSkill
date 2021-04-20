//
//  OngoingTasksTableViewController.swift
//  TimingYourSkill3.0
//
//  Created by Pavlo Ostrozhynskyi on 26.03.2021.
//

import UIKit
import Loaf

protocol OngoingTaskTVCDelegate: class  { /// настройки для видалення таски
    func showOptions (for task: Task)
}

class OngoingTasksTableViewController: UITableViewController, Animatable {
    
    private let databaseManager = DatabaseManager()
    private let authManager = AuthManager()
    
    
    private var tasks: [Task] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    weak var delegate: OngoingTaskTVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTasksListener()
        
    }
    
    private func addTasksListener() { /// Зберігає данні введені в tableview
        guard let uid = authManager.getUserId()else {
            print("no user found")
            return}
        
        databaseManager.addTasksListener(forDoneTasks: false, uid: uid) { [weak self] (result) in
            switch result{
            case .success(let tasks):
                self?.tasks = tasks
            case .failure(let error):
                self?.showToast(state: .error, message: error.localizedDescription)
            }
        }
    }
    
    private func handleActionButton(for task: Task) {
        guard let id = task.id else { return }
        databaseManager.updateTaskStatus(id: id, isDone:  true) { [weak self] (result) in
            switch result{
            case .success:
                self?.showToast(state: .info, message: "Move to Done", duration: 2.0)
            case .failure(let error):
                self?.showToast(state: .error, message: error.localizedDescription)
            }
        }
        
    }
    
}

extension OngoingTasksTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! OngoinTaskTableViewCell
        let task = tasks[indexPath.row ]
        cell.actionButtonDidTap = { [weak self] in
            self?.handleActionButton(for: task)
        }
        cell.configure(with: task)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let task = tasks[indexPath.item]
        delegate?.showOptions(for: task)
    }
}
