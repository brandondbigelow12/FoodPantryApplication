//
//  InventoryPageTableViewCell.swift
//  FoodPantryApplication
//
//  Created by Brandon Bigelow on 11/25/17.
//  Copyright © 2017 Brandon Bigelow. All rights reserved.
//

import UIKit

class InventoryPageTableViewCell: UITableViewCell {
    @IBOutlet var myImage: UIImageView!
    
    @IBOutlet var myItemName: UILabel!
    
    @IBOutlet var quantityTextLabel: UILabel!
    
    @IBOutlet var actualQuantityTextLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
 

}
