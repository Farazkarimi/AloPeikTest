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


class OrdersManager{
    
    private var ordersArray:NSMutableArray!
    private var order = OrderObject() {
        didSet{
            ordersArray.add(self.order)
            if ((self.delegate) != nil){
                self.delegate.didAddNewOrder(order: self.order)
            }
            self.updateOrderStatus(order: self.order)
        }
    }
    
    public var delegate:OrderManagerDelegate!
    
    class var sharedInstance: OrdersManager {
        struct Static {
            static let instance: OrdersManager = OrdersManager()
        }
        return Static.instance
    }
    
    init() {
        self.ordersArray = NSMutableArray()
    }
    
    public func addOrder(name:String, address:String, latitude:Double, longitude:Double){
        self.order = OrderObject(orderName: name, orderAddress: address, orderStatus: orderState.pending, latitude: latitude, longitude: longitude)
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
