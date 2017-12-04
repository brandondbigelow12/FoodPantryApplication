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
import UserNotifications

class PantrySelection : UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    var userEmail = String()
    var GoogleUserEmail = String()
    var SelectedOrganization = String()
    
    @IBOutlet var userProfilePicture: UIImageView!
    
    
    var Organizations =  [String!]()
    
    //var Organizations = ["Hello","Test", "Yes"]
    
    @IBOutlet var welcomeBanner: UILabel!
    @IBOutlet var pantrySelectionLabel: UILabel!
    @IBAction func LogoutButton(_ sender: Any) {
    }
    
    @IBOutlet var PickerWheel: UIPickerView!
    
    let databaseRef = Database.database().reference()
    var databaseHandle : DatabaseHandle!
    
     let loggedInUser = String()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { didAllow, error in #imageLiteral(resourceName: "LoginScreenBackground")
            
            
        })
       
        Greeting()
        getFirebaseData()
       PickerWheel.selectedRow(inComponent: 0)
    }
   
    
    func Greeting()
    {
        if(GoogleUser.getGoogleUserEmail().isEmpty)
        {
            welcomeBanner.text = "Welcome \(userEmail)" as String!
            self.userProfilePicture.layer.cornerRadius = self.userProfilePicture.frame.size.width / 2
            self.userProfilePicture.clipsToBounds = true
            self.userProfilePicture.image = #imageLiteral(resourceName: "puppy")
            self.loggedInUser == userEmail
        }
        else
        {
            welcomeBanner.text = "Welcome \(GoogleUser.getGoogleUserEmail()!)" as String!
            self.loggedInUser == GoogleUser.getGoogleUserEmail()
            
            if let url = GoogleUser.getGoogleProfileImage()
            {
                
                let urlRequest = URLRequest(url: url)
                
                let session = URLSession.shared
                
                session.dataTask(with: urlRequest){
                    (data, response, err) in
                    
                    if err != nil {
                        print("ERROR \(err!)")
                        return
                    }
                    DispatchQueue.main.async
                        {
                            self.userProfilePicture.layer.cornerRadius = self.userProfilePicture.frame.size.width / 2
                            self.userProfilePicture.clipsToBounds = true
                            
                            self.userProfilePicture.image = UIImage(data: data!)
                            
                    }
                    }.resume()
            }
            
        }
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
        pantrySelectionLabel.text = Organizations[row]
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
            performSegue(withIdentifier: "inventoryPage", sender: nil)
    }
    
    override func prepare(for segue : UIStoryboardSegue, sender : Any?)
    {
        if segue.identifier == "inventoryPage"
        {
            let SecondController = segue.destination as! InventoryPage
            SecondController.SelectedOrganization = SelectedOrganization
        }
        if segue.identifier == "LoginView"
        {
          
        }
        
    }
    
   
    
    @IBAction func logoutButton(_ sender: Any) {
        
        do{
            
        let auth = Auth.auth()
        try auth.signOut()
        print("LOGGED OUT!")
        print("LOGGED OUT USER \(auth.currentUser)")
      
        self.performSegue(withIdentifier: "LoginView", sender: nil)
        }
        catch let error as NSError
        {
            print(error.localizedDescription)
        }
        
    }
}
extension UIViewController
{
    @objc func swipeAction(swipe : UISwipeGestureRecognizer)
    {
        switch swipe.direction.rawValue {
        case 1:
            performSegue(withIdentifier: "goLeft", sender: nil)
            break
        default:
            break
        }
    }
}
