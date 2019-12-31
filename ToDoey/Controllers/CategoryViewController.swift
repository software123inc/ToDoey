//
//  CategoryViewController.swift
//  ToDoey
//
//  Created by Tim Newton on 12/7/19.
//  Copyright © 2019 EduServe, Inc. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    var tableData = [Categorization]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        var alertTextField = UITextField()
        
        let alert = UIAlertController(title:
            "Add New Category", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            print(alertTextField.text ?? "Did not enter text")
            
            if let newText = alertTextField.text, !newText.isEmpty {
                let newObject = Categorization(context: self.viewContext)
                newObject.name = newText
                
                self.tableData.append(newObject)
                self.saveItems()
            }
        }
        
        alert.addAction(action)
        
        alert.addTextField { (inTextField) in
            inTextField.placeholder = "Enter new item"
            alertTextField = inTextField
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = tableData[indexPath.row].name
        
        return cell
    }
    
    // MARK: - Table view delegate source
    
}

// MARK: - data management

extension CategoryViewController {
    func loadItems(with request:NSFetchRequest<Categorization> = Categorization.fetchRequest()) {
        do {
            tableData = try viewContext.fetch(request)
            tableView.reloadData()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func saveItems() {
        appDelegate.saveContext()
        self.tableView.reloadData()
    }
}
