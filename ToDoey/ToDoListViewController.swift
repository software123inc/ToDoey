//
//  ToDoListViewController.swift
//  ToDoey
//
//  Created by Tim Newton on 11/27/19.
//  Copyright © 2019 EduServe, Inc. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    let itemArray = ["Find Mike", "Buy Eggs", "Destroy Demogorgon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

//MARK: - UITableViewDataSource

extension ToDoListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension ToDoListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if let cell = cell {
            cell.accessoryType = (cell.accessoryType == .checkmark) ? .none : .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
