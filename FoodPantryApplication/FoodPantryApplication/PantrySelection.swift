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
import Alamofire

class PantrySelection : UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    var userEmail = String()
    var SelectedOrganization = String()
    
    var Organizations =  [String!]()
    
    //var Organizations = ["Hello","Test", "Yes"]
    
    @IBOutlet var welcomeBanner: UILabel!
    @IBOutlet var pantrySelectionLabel: UILabel!

    @IBOutlet var PickerWheel: UIPickerView!
    
    let databaseRef = Database.database().reference()
    var databaseHandle : DatabaseHandle!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        welcomeBanner.text = "Welcome " + userEmail
        getFirebaseData()
        //post()
    }
    
    func getFirebaseData()
    {
            self.databaseRef.child("Pantries").observe(.childAdded, with: { ( snapshot) in

            //self.Organizations.append(snapshot.key)

                if let snapDict = snapshot.key as? String!
                {
                    self.Organizations.append(snapDict as String!)
                    print(snapDict)
                }
                self.PickerWheel.reloadAllComponents()
            })
    }
    
    func post()
    {
        let x  = postItemsToFirebase()
        x.postItemToFirebase(organization: "OLG")
    }
    

    func loadPantryLocationFromFirebase()
    {
        print("View of my pantries!")
        print(Organizations)
    }


    //PickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Organizations[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Organizations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pantrySelectionLabel.text = Organizations[row]
       
    }
    
    
    //Button that will load specified Organization's inventory on the next page
    @IBAction func viewInventoryButton(_ sender: Any)
    {
            SelectedOrganization = pantrySelectionLabel.text!
            performSegue(withIdentifier: "goToInventory", sender: nil)
    }
    
    override func prepare(for segue : UIStoryboardSegue, sender : Any?)
    {
        let SecondController = segue.destination as! InventoryPage
        SecondController.SelectedOrganization = SelectedOrganization
        
    }
    
    

    
      
        
}
