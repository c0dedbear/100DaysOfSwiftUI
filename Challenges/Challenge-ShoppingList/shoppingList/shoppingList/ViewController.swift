//
//  ViewController.swift
//  shoppingList
//
//  Created by Mikhail Medvedev on 25.10.2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var shoppingList = [String]()

//MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addBarItems()
    }

//MARK: - Methods
    private func addBarItems() {
        
        let clearButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearListTapped))
        clearButton.tintColor = .systemRed
        navigationItem.leftBarButtonItem = clearButton
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemTapped))
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        navigationItem.rightBarButtonItems = [addButton, shareButton]
    }
    
    @objc func addItemTapped() {
        //add new item to list
        let ac = UIAlertController(title: "New item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let addItemAction = UIAlertAction(title: "Add", style: .default) { _ in
            if let text = ac.textFields?.first?.text {
                self.shoppingList.insert(text, at: 0)
                let indexPath = IndexPath(row: 0, section: 0)
                self.tableView.insertRows(at: [indexPath], with: .automatic)
            }
        }
        ac.addAction(cancelAction)
        ac.addAction(addItemAction)
        present(ac, animated: true)
        
    }
    
    @objc func clearListTapped() {
        //erase items
        shoppingList.removeAll()
        tableView.reloadData()
    }
    
    @objc func shareTapped() {
        let items = shoppingList.joined(separator: "\n")
        let ac = UIActivityViewController(activityItems: [items], applicationActivities: nil)
        present(ac, animated: true)
    }
    
}

//MARK: - DataSource
extension TableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopCell", for: indexPath)
        let item = shoppingList[indexPath.row]
        cell.textLabel?.text = item
        return cell
    }
}
