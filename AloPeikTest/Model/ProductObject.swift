//
//  ProductObject.swift
//  AloPeikTest
//
//  Created by Faraz Karimi on 12/16/18.
//  Copyright © 2018 Faraz Karimi. All rights reserved.
//

import UIKit

class ProductObject: NSObject {
    
    var productName:String!
    var productID:NSNumber!
    var categoryID:NSNumber!
    
    convenience init(productName:String, productID:NSNumber, categoryID:NSNumber) {
        self.init()
        self.productName = productName
        self.productID = productID
        self.categoryID = categoryID
    }
}
