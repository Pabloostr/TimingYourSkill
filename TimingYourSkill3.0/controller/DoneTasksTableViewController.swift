//
//  DoneTasksTableViewController.swift
//  TimingYourSkill3.0
//
//  Created by Pavlo Ostrozhynskyi on 26.03.2021.
//

import UIKit

class DoneTasksTableViewController: UITableViewController {
    
    private var tasks: [Task] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    private let databaseManager = DatabaseManeger()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTasksListener()
    }
    
    private func addTasksListener() { /// Зберігає данні введені в tableview
        databaseManager.addTasksListener(forDoneTasks: true) { [weak self] (result) in
            switch result{
            case .success(let tasks):
                self?.tasks = tasks
            case .failure(let error):
                print(error )
            }
        }
    }
    
}


extension DoneTasksTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! DoneTaskTableViewCell
        let task = tasks[indexPath.item]
        cell.configure(with: task)
        return cell
    }
    
}
