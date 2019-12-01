//
//  ToDoListViewController.swift
//  ToDoey
//
//  Created by Tim Newton on 11/27/19.
//  Copyright © 2019 EduServe, Inc. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = ["Find Mike", "Buy Eggs", "Destroy Demogorgon"]
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Add New Items
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        var alertTextField = UITextField()
        
        let alert = UIAlertController(title:
            "Add New Item", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print(alertTextField.text ?? "Did not enter text")
            
            if let newText = alertTextField.text, !newText.isEmpty {
                self.itemArray.append(newText)
                self.tableView.reloadData()
            }
        }
        
        alert.addAction(action)
        
        alert.addTextField { (inTextField) in
            inTextField.placeholder = "Enter new item"
            alertTextField = inTextField
        }
        
        present(alert, animated: true, completion: nil)
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


