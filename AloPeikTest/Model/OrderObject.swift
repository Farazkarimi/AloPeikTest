//
//  OrderObject.swift
//  AloPeikTest
//
//  Created by Faraz Karimi on 12/16/18.
//  Copyright © 2018 Faraz Karimi. All rights reserved.
//

import UIKit

public enum orderState : Int {
    case pending = 1
    case inProgress
    case delivery
    case delivered
    static let allValues = [pending, inProgress, delivery, delivered]
}

class OrderObject: NSObject {
    
    var orderName:String!
    var orderAddress:String!
    var orderStatus:orderState!
    var orderLatitude:Double!
    var orderLongitude:Double!
    
    convenience init(orderName:String, orderAddress:String, orderStatus:orderState, latitude:Double, longitude:Double) {
        self.init()
        self.orderName = orderName
        self.orderAddress = orderAddress
        self.orderStatus = orderStatus
        self.orderLatitude = latitude
        self.orderLongitude = longitude
    }
}
