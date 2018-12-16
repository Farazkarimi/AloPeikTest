//
//  CategoriesTableViewController.swift
//  AloPeikTest
//
//  Created by Faraz Karimi on 12/16/18.
//  Copyright © 2018 Faraz Karimi. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    
    var categoriesDatasourceArray:NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialViews()
        self.initialValues()
    }
    
    private func initialViews(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.topItem?.title = "Categories"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        
        self.tableView.allowsSelection = true
        //self.tableView.tableFooterView = UIView()
    }
    
    private func initialValues(){
        categoriesDatasourceArray = NSMutableArray(array: FakeDataClass.sharedInstance.categoryListGenerator(capacity: 100))
        self.tableView.reloadData()
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoriesDatasourceArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoriesCell", for: indexPath)
        cell.textLabel?.text = (categoriesDatasourceArray[indexPath.row] as! CategoryObject).categoryName
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productsTableViewController = ProductsTableViewController(nibName: "ProductsTableViewController", bundle: nil)
        productsTableViewController.categoryID = (self.categoriesDatasourceArray[indexPath.row] as! CategoryObject).categoryID
        self.navigationController?.pushViewController(productsTableViewController, animated: true)
    }
    
}
