//
//  postItemsToFirebase.swift
//  FoodPantryApplication
//
//  Created by Brandon Bigelow on 11/21/17.
//  Copyright © 2017 Brandon Bigelow. All rights reserved.
//

import Foundation
import FirebaseDatabase

class postItemsToFirebase
{
    var ref: DatabaseReference!
    let databaseRef = Database.database().reference()
    
    func postItemToFirebase(organization: NSString!)
    {
        let organization = "OLG"
        //Database
        
        let itemTitle = "Coca-Cola"
        let imageURL = "www.google.com"
        let quantity = "5"
        
        let post : [NSString : AnyObject] = [
            "ItemTitle" : itemTitle as NSString,
            "ImageURL" : imageURL as NSString,
            "Quantity" : quantity as NSString]
        
        
        databaseRef.child("Pantries/\(organization)/Items").childByAutoId().setValue(post)
    }
    
}


//UPDAT DATABASE

//    @IBAction func updateDatabase(_ sender: Any) {
//
//        let Message = "WEEE "
//        let imageURL = "This worked!"
//        let quantity = "100"
//
//        let post : [String : AnyObject ] = [
//            "Message" : Message as AnyObject,
//            "ImageURL" : imageURL as AnyObject,
//            "Quantity" : quantity as AnyObject]
//
//        databaseRef.child("\(Organization)/Items").childByAutoId().updateChildValues(post)

///////////////////////

///POST TO DATABASE
//        let itemTitle = "Mountain Dew - 12 oz. cans - 36 pk"
//        let imageURL = "http://8016235491c6828f9cae-6b0d87410f7cc1525cc32b79408788c4.r96.cf2.rackcdn.com/3368/82985840_1.jpg"
//        let quantity = "1"
//
//         let post : [NSString : AnyObject] = [
//                                            "ItemTitle" : itemTitle as NSString,
//                                            "ImageURL" : imageURL as NSString,
//                                            "Quantity" : quantity as NSString]
//
//
//        databaseRef.child("\(tempOrganization!)/Items").childByAutoId().setValue(post)
//    }
