//
//  ProductsTableViewController.swift
//  AloPeikTest
//
//  Created by Faraz Karimi on 12/16/18.
//  Copyright © 2018 Faraz Karimi. All rights reserved.
//

import UIKit

class ProductsTableViewController: UITableViewController,UITabBarControllerDelegate,productCellDelegate {
    func didPressedBuyButton(product: ProductObject) {
        let mapViewController = MapViewController(nibName: "MapViewController", bundle: nil)
        self.present(mapViewController, animated: true, completion: nil)
    }
    
    
    
    private var productsDataSurceArray:NSMutableArray!
    public var categoryID:NSNumber!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialViews()
        self.initialValues()
    }
    
    
    private func initialViews(){
        self.navigationItem.title = "Products"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        
        self.tableView.allowsSelection = true
        //self.tableView.tableFooterView = UIView()
        
        tableView.register(UINib(nibName: "ProductsTableViewCell", bundle: nil), forCellReuseIdentifier: "productsCell")
    }
    
    private func initialValues(){
        productsDataSurceArray = NSMutableArray(array: FakeDataClass.sharedInstance.generateProductForCategories(categoryID: self.categoryID, capacity: 15))
        self.tabBarController?.delegate = self
        self.tableView.allowsSelection = false
        self.tableView.reloadData()
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return productsDataSurceArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productsCell", for: indexPath) as! ProductsTableViewCell
        cell.delegate = self
        cell.configCell(product: productsDataSurceArray[indexPath.row] as! ProductObject)
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
