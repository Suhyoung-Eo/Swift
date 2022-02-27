//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Suhyoung Eo on 2021/10/06.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
        
    let realm = try! Realm()
    var categories: Results<Category>?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let navBar = navigationController?.navigationBar else {fatalError("Navigation controller does not exist.")}
                
        navBar.standardAppearance.backgroundColor = UIColor(hexString: "1D9BF6")
        navBar.scrollEdgeAppearance?.backgroundColor = UIColor(hexString: "1D9BF6")

        let textColor = [NSAttributedString.Key.foregroundColor: UIColor.white]

        navBar.standardAppearance.titleTextAttributes = textColor
        navBar.standardAppearance.largeTitleTextAttributes = textColor
        navBar.scrollEdgeAppearance?.titleTextAttributes = textColor
        navBar.scrollEdgeAppearance?.largeTitleTextAttributes = textColor
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)        
        
        
        if let category = categories?[indexPath.row] {
            cell.textLabel?.text = category.name
            
            guard let categoryColor = UIColor(hexString: category.color) else {fatalError()}
            
            cell.backgroundColor = categoryColor
            cell.textLabel?.textColor = ContrastColorOf(categoryColor, returnFlat: true)
        } else {
            cell.textLabel?.text = "No Categories Added Yet"
        }
        
        
        return cell
    }
    

    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    //MARK: - Delete Data From Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        if let category = categories?[indexPath.row] {
            do {
                try realm.write({
                    realm.delete(category)
                })
            } catch {
                print("Error deleting category \(error)")
            }
        }
    }
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { action in
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.color = UIColor.randomFlat().hexValue()
            
            self.saveCategories(category: newCategory)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(action)
        alert.addAction(cancelAction)
        
        alert.addTextField { alerTextField in
            textField = alerTextField
            textField.placeholder = "Create a new category"
        }
        
        present(alert, animated: true, completion: nil)
        
        tableView.reloadData()
    }
    
    //MARK: - Data Mainpulation Methods
    
    
    func saveCategories(category: Category) {
        do {
            try realm.write({
                realm.add(category)
            })
        } catch {
            print("Error saving category \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories() {
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
}
