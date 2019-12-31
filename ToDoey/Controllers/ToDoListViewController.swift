//
//  ToDoListViewController.swift
//  ToDoey
//
//  Created by Tim Newton on 11/27/19.
//  Copyright © 2019 EduServe, Inc. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    var itemArray = [Item]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadItems()
    }
    
    //MARK: - Add New Items
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        var alertTextField = UITextField()
        
        let alert = UIAlertController(title:
            "Add New Item", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print(alertTextField.text ?? "Did not enter text")
            
            if let newText = alertTextField.text, !newText.isEmpty {
                let newItem = Item(context: self.viewContext)
                newItem.title = newText
                newItem.done = false
                
                self.itemArray.append(newItem)
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
    
    func loadItems(with request:NSFetchRequest<Item> = Item.fetchRequest()) {
        do {
            itemArray = try viewContext.fetch(request)
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

//MARK: - UITableViewDataSource

extension ToDoListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        cell.accessoryType = (itemArray[indexPath.row].done) ? .checkmark : .none
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension ToDoListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        viewContext.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK:- UISearchBarDelegate

extension ToDoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        let sort = NSSortDescriptor(key: "title", ascending: true)
        
        request.predicate = predicate
        request.sortDescriptors = [sort]
        
        loadItems(with: request)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
            loadItems()
        }
    }
}
