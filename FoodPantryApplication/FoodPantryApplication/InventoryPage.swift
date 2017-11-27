//
//  InventoryPage.swift
//  FoodPantryApplication
//
//  Created by Brandon Bigelow on 11/20/17.
//  Copyright © 2017 Brandon Bigelow. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import Firebase

class InventoryPage : UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var SelectedOrganization = String()
    
    let databaseRef = Database.database().reference()
    var databaseHandle : DatabaseHandle!
    
    
    //let list = ["Milk", "Honey", "Bread" , "Tacos", "Water", "Eggs"]
    var itemTitlearray = [String!]()
    var itemQuantityarray = [String!]()
    var itemImageURL = [String!]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        databaseRef.database.reference().child("Pantries/OLG/Items/").observe(.childAdded, with: { ( snapshot) in
            
            if let snapDict = snapshot.value as? NSDictionary
            {
                let imageURL = snapDict["ImageURL"] as? String!
                let itemTitle = snapDict["ItemTitle"] as? String!
                let Quantity = snapDict["Quantity"] as? String!
                self.itemTitlearray.append(itemTitle)
                self.itemQuantityarray.append(Quantity)
                self.itemImageURL.append(imageURL)
            }
            
           
        })
    }
         
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return itemTitlearray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
      //  let cell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier : "cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath) as! InventoryPageTableViewCell
        //cell.textLabel?.text = itemTitlearray[indexPath.row]
        
        
        cell.quantityTextLabel.text = "Quantity"
        cell.myItemName.text  = itemTitlearray[indexPath.row]
        cell.actualQuantityTextLabel.text = itemQuantityarray[indexPath.row]
        
        
        if let url = URL(string: itemImageURL[indexPath.row]) {

            let urlRequest = URLRequest(url: url)

            let session = URLSession.shared

            session.dataTask(with: urlRequest){
                (data, response, err) in

                if err != nil {
                    print("ERROR \(err!)")
                    return
                }
                DispatchQueue.main.async {
                    cell.myImage?.image = UIImage(data: data!)
                    let y = 8
                }
                }.resume()

        }
        
        return (cell)
    }
    
}
