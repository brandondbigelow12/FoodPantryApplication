//
//  InventoryPage.swift
//  FoodPantryApplication
//
//  Created by Brandon Bigelow on 11/20/17.
//  Copyright © 2017 Brandon Bigelow. All rights reserved.
//

import Foundation
import UIKit

class InventoryPage : UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var SelectedOrganization = String()
    
    let list = ["Milk", "Honey", "Bread" , "Tacos", "Water", "Eggs"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return list.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier : "cell")
        cell.textLabel?.text = list[indexPath.row]
        return (cell)
    }
    
}
