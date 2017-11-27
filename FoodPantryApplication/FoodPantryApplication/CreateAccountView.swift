//
//  PantrySelection.swift
//  FoodPantryApplication
//
//  Created by Brandon Bigelow on 11/16/17.
//  Copyright © 2017 Brandon Bigelow. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseAnalytics

class CreateAccountView: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet var emailField: UITextField!
    
    @IBOutlet var passwordField: UITextField!
    
    @IBOutlet var confirmPasswordField: UITextField!
    
    @IBAction func CreateFirebaseAccount(_ sender: UIButton) {
        if(emailField.text == nil || passwordField.text == nil)
        {
            print("Fields were empty")
        }
        else if (passwordField.text != confirmPasswordField.text)
        {
            let alertController = UIAlertController(title: "Whoops!", message: "Passwords do not match!", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { (user, error) in
            
            if(error == nil)
            {
                print("Created Account " + (user?.email)!)
                self.performSegue(withIdentifier: "inventoryPage", sender: nil)
                
            }
            else
            {
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
        if segue.identifier == "inventoryPage"
        {
            let SecondController = segue.destination as! PantrySelection
            SecondController.userEmail = emailField.text!
        }
    }
    
}
