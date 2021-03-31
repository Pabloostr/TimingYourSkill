//
//  OngoingTasksTableViewController.swift
//  TimingYourSkill3.0
//
//  Created by Pavlo Ostrozhynskyi on 26.03.2021.
//

import UIKit

class OngoingTasksTableViewController: UITableViewController {
    
    private let databaseManager = DatabaseManeger()
    
    
    private var tasks: [Task] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTasksListener()

    }
    
    private func addTasksListener() { /// Зберігає данні введені в tableview
        databaseManager.addTasksListener(forDoneTasks: false) { [weak self] (result) in
            switch result{
            case .success(let tasks):
                self?.tasks = tasks
            case .failure(let error):
                print(error )
            }
        }
    }
    
    private func handleActionButton(for task: Task) {
        guard let id = task.id else { return }
        databaseManager.updateTaskToDone(id: id) { (result) in
            switch result{
            case .success:
                print("set to done succesfully")
            case .failure(let error):
                print(error.localizedDescription)
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
}
