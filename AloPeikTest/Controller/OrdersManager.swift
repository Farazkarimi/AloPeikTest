//
//  OrdersManager.swift
//  AloPeikTest
//
//  Created by Faraz Karimi on 12/16/18.
//  Copyright © 2018 Faraz Karimi. All rights reserved.
//

import UIKit


protocol OrderManagerDelegate {
    func didUpdateOrder(order:OrderObject)
    func didAddNewOrder(order:OrderObject)
}


class OrdersManager: NSObject {
    
    private var ordersArray:NSMutableArray!
    public var delegate:OrderManagerDelegate!
    
    class var sharedInstance: OrdersManager {
        struct Static {
            static let instance: OrdersManager = OrdersManager()
        }
        return Static.instance
    }
    
    override init() {
        self.ordersArray = NSMutableArray()
    }
    
    public func addOrder(name:String, address:String, latitude:Double, longitude:Double){
        let order = OrderObject(orderName: name, orderAddress: address, orderStatus: orderState.pending, latitude: latitude, longitude: longitude)
        ordersArray.add(order)
        self.delegate.didAddNewOrder(order: order)
        self.updateOrderStatus(order: order)
    }
    
    
    public func updateOrderStatus(order:OrderObject){
        unowned let unownedSelf:OrdersManager = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 30.0, execute: {
            if order.orderStatus.rawValue<4{
                order.orderStatus = orderState(rawValue: order.orderStatus.rawValue+1)
                unownedSelf.delegate.didUpdateOrder(order: order)
            }
            unownedSelf.updateOrderStatus(order: order)
        })
    }
    
    
    public func getActiveOrders() -> NSArray{
        return ordersArray
    }
}
