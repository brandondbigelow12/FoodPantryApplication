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
        
        let itemTitle = "Puppy"
        let imageURL = "data:image/png;base64,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"
        let quantity = "28"
        
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
