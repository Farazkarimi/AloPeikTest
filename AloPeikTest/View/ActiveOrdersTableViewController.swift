//
//  ActiveOrdersTableViewController.swift
//  AloPeikTest
//
//  Created by Faraz Karimi on 12/16/18.
//  Copyright © 2018 Faraz Karimi. All rights reserved.
//

import UIKit

class ActiveOrdersTableViewController: UITableViewController,OrderManagerDelegate {
    
    var ordersDatasourceArray:NSMutableArray!
    var orderManager:OrdersManager!
    var updateDateSourceTimer:Timer!
    
    func didUpdateOrder(order: OrderObject) {
        self.tableView.reloadData()
    }
    
    func didAddNewOrder(order: OrderObject) {
        ordersDatasourceArray.add(order)
        self.tableView.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialViews()
        self.initialValues()
    }
    
    private func initialViews(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.topItem?.title = "Active Orders"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1612317562, green: 0.6466587782, blue: 0.8905015588, alpha: 1)
        
        self.tableView.allowsSelection = false
    }
    
    private func initialValues(){
        ordersDatasourceArray = NSMutableArray()
        orderManager = OrdersManager.sharedInstance
        orderManager.delegate = self
        ordersDatasourceArray = orderManager.getActiveOrders().mutableCopy() as? NSMutableArray
        self.tableView.tableFooterView = UIView()
    }
    
    private func startTimer(){
        unowned let unownedSelf = self
        updateDateSourceTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (timer) in
            unownedSelf.ordersDatasourceArray = unownedSelf.orderManager.getActiveOrders().mutableCopy() as? NSMutableArray
            unownedSelf.tableView.reloadData()
        })
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ordersDatasourceArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activeOrdersCell", for: indexPath)
        
        let order:OrderObject = ordersDatasourceArray?[indexPath.row] as! OrderObject
        
        cell.textLabel?.text = order.orderName!
        cell.detailTextLabel?.text = {
            if ((order.orderAddress) != nil){
                return "Status: " + stringOrderStatus(order:order.orderStatus) + "     Address: " + order.orderAddress
            }else{
                return "Status: " + stringOrderStatus(order: order.orderStatus)
            }
        }()
        return cell
    }
    
    private func stringOrderStatus(order:orderState) -> String{
        switch order {
        case .delivered:
            return "Delivered"
        case .delivery:
            return "Delivery"
        case .inProgress:
            return "in-process"
        case .pending:
            return "Pending"
        }
    }
}

