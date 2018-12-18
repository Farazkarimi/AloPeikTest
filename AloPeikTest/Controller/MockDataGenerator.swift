//
//  FakeDataClass.swift
//  AloPeikTest
//
//  Created by Faraz Karimi on 12/16/18.
//  Copyright © 2018 Faraz Karimi. All rights reserved.
//

import UIKit
import Fakery

class MockDataGenerator: NSObject {
    private var categoryListArray:NSMutableArray!
    private var productDictionary:NSMutableDictionary!
    private var faker:Faker!
    class var sharedInstance: MockDataGenerator {
        struct Static {
            static let instance: MockDataGenerator = MockDataGenerator()
        }
        return Static.instance
    }
    
    override init() {
        self.categoryListArray = NSMutableArray()
        self.productDictionary = NSMutableDictionary()
        self.faker = Faker(locale: "nb-NO")
    }
    
    public func categoryListGenerator(capacity:NSNumber) -> NSArray{
        if self.categoryListArray.count>0{
            return self.categoryListArray
        }
        
        let categories = NSMutableArray(capacity: Int(truncating: capacity))
        
        for i in 0...Int(truncating: capacity)-1 {
            categories.add(CategoryObject(categoryName: self.faker.name.firstName() + " " + self.faker.company.name(), categoryID: NSNumber(value: i)))
        }
        categoryListArray = categories
        
        return categoryListArray
    }
    public func generateProductForCategories(categoryID:NSNumber, capacity:NSNumber) -> NSArray{
        
        if (productDictionary[categoryID] != nil) {
            return productDictionary?[categoryID] as! NSArray;
        }
        
        let products = NSMutableArray(capacity: Int(truncating: capacity))
        for i in 0...Int(truncating: capacity)-1{
            products.add(ProductObject(productName: self.faker.name.lastName() + " " + self.faker.company.suffix(), productID: NSNumber(value: i), categoryID: categoryID))
        }
        productDictionary[categoryID] = products
        return productDictionary?[categoryID] as! NSArray
    }
}
