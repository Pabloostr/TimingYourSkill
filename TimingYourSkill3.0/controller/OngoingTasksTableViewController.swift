//
//  OngoingTasksTableViewController.swift
//  TimingYourSkill3.0
//
//  Created by Pavlo Ostrozhynskyi on 26.03.2021.
//

import UIKit

class OngoingTasksTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension OngoingTasksTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        return cell
    }
}
