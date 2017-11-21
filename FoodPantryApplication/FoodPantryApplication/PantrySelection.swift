//
//  PantrySelection.swift
//  FoodPantryApplication
//
//  Created by Brandon Bigelow on 11/19/17.
//  Copyright © 2017 Brandon Bigelow. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase



class PantrySelection : UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    var userEmail = String()
    var SelectedOrganization = String()
    let Organizations =  ["OLG" , "Full Sail" , "Holy Name"]
    
    @IBOutlet var welcomeBanner: UILabel!
    @IBOutlet var pantrySelectionLabel: UILabel!

    @IBOutlet var PickerWheel: UIPickerView!
    
    //Database
    var ref: DatabaseReference!
    let databaseRef = Database.database().reference()
    
    @IBOutlet var conditionLabel: UILabel!
    var tempOrganization : String! = nil
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        welcomeBanner.text = "Welcome " + userEmail
        
    }
    
    
    func post()
    {
        
        let Message = "Food pantry items"
        let imageURL = "Test Image URL"
        let quantity = "89"
        
        let post : [String : AnyObject] = [
                                            "Message" : Message as AnyObject,
                                            "ImageURL" : imageURL as AnyObject,
                                            "Quantity" : quantity as AnyObject]
        
        databaseRef.child("\(tempOrganization)/Items").childByAutoId().setValue(post)
    }
    
    //PickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pantrySelectionLabel.text = Organizations[row]
        tempOrganization = pantrySelectionLabel.text
        return Organizations[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Organizations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pantrySelectionLabel.text = Organizations[row]
        tempOrganization = pantrySelectionLabel.text
    }
    
    //Button that will load specified Organization's inventory on the next page
    @IBAction func viewInventoryButton(_ sender: Any)
    {
            performSegue(withIdentifier: "goToInventory", sender: nil)
            post()
    }
    
    override func prepare(for segue : UIStoryboardSegue, sender : Any?)
    {
        let SecondController = segue.destination as! InventoryPage
        SecondController.SelectedOrganization = SelectedOrganization
        
    }
    
    
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
    
      
        
}
