//
//  ViewController.swift
//  FoodPantryApplication
//
//  Created by Brandon Bigelow on 11/16/17.
//  Copyright © 2017 Brandon Bigelow. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class LoginView: UIViewController {
    
    var userEmail : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set the Login Background image
         //view.layer.contents = #imageLiteral(resourceName: "LoginScreenBackground").cgImage
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    @IBOutlet var emailField: UITextField!
    
    @IBOutlet var password: UITextField!
    
    @IBOutlet var loginButton: UIButton!
    
    
    @IBAction func loginButton(_ sender: UIButton)
    {
        print("button pressed")
        if self.emailField.text == "" || self.password.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().signIn(withEmail: self.emailField.text!, password: self.password.text!) { (user, error) in
                
                if error == nil {
                    print("User has successfully logged in")
                    //Set variable to the local variable. This is set so it can be sent to the next view in the overriden function
                    self.userEmail = (user?.email)!
                    //Change from one view to another.
                    self.performSegue(withIdentifier: "inventoryPage", sender: nil)
                    
                } else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func prepare(for segue : UIStoryboardSegue, sender : Any?)
    {
        let SecondController = segue.destination as! PantrySelection
        SecondController.userEmail = userEmail
        
    }
    
    @IBAction func CreateAccountButton(_ sender: UIButton) {
        performSegue(withIdentifier: "test", sender: nil)
    }
    
}
