//
//  ProductsTableViewCell.swift
//  AloPeikTest
//
//  Created by Faraz Karimi on 12/16/18.
//  Copyright © 2018 Faraz Karimi. All rights reserved.
//

import UIKit
protocol productCellDelegate {
    func didPressedBuyButton(product:ProductObject)
}

class ProductsTableViewCell: UITableViewCell {
    
    var delegate:productCellDelegate!
    var product:ProductObject!
    @IBOutlet weak var productName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    public func configCell(product:ProductObject){
        self.product = product
        self.productName.text = product.productName
    }
    
    @IBAction func buyProductButton(_ sender: UIButton) {
        if (self.delegate != nil){
        self.delegate.didPressedBuyButton(product: self.product)
        }
    }
}
