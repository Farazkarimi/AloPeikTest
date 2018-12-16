//
//  CategoryObject.swift
//  AloPeikTest
//
//  Created by Faraz Karimi on 12/16/18.
//  Copyright © 2018 Faraz Karimi. All rights reserved.
//

import UIKit

class CategoryObject: NSObject {
    
    var categoryName:String!
    var categoryID:NSNumber!
    
    convenience init(categoryName:String, categoryID:NSNumber) {
        self.init()
        self.categoryName = categoryName
        self.categoryID = categoryID
    }
}
