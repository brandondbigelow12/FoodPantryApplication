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
    var itemImageURL = [String!]()
    var itemQuantityarray = [Int32!]()
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
      
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(rightSwipe)
        
        databaseRef.database.reference().child("Pantries/\(SelectedOrganization)/Items/").observe(.childAdded, with: { ( snapshot) in
            
            if let snapDict = snapshot.value as? NSDictionary
            {
                let imageURL = snapDict["ImageURL"] as? String!
                let itemTitle = snapDict["ItemTitle"] as? String!
                var quantity = snapDict["Quantity"] as! String!
                let quantityInt: Int32? = Int32(quantity!)
                self.itemTitlearray.append(itemTitle)
                self.itemQuantityarray.append(quantityInt)
                self.itemImageURL.append(imageURL)
            }
            
           
        })
    }
    
    @objc func backSegue() {
        performSegue(withIdentifier: "PantrySelection", sender: self)
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
        
        cell.myItemName.text  = itemTitlearray[indexPath.row]
        //cell.actualQuantityTextLabel.text = itemQuantityarray[indexPath.row]
        
        let quantity = (itemQuantityarray[indexPath.row])
        
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 3
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true        
        
        switch quantity {
        case let quantity where quantity! > 50:
            cell.actualQuantityTextLabel.text = String(describing: "Quantity \(itemQuantityarray[indexPath.row]!)")
            cell.contentView.backgroundColor = UIColor.green
            break
        case let quantity where quantity! < 50 && quantity! > 20:
            cell.actualQuantityTextLabel.text = String(describing: "Quantity \(itemQuantityarray[indexPath.row]!)")
            cell.contentView.backgroundColor = UIColor.yellow
            case let quantity where quantity! < 10:
                cell.actualQuantityTextLabel.text = String(describing: "Quantity \(itemQuantityarray[indexPath.row]!)")
                cell.contentView.backgroundColor = UIColor.red
        default:
            cell.actualQuantityTextLabel.text = String(describing: "Quantity \(itemQuantityarray[indexPath.row]!)")
            cell.contentView.backgroundColor = UIColor.purple
            break
        }
        
        
        
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
