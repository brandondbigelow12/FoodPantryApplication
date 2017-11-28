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
import GoogleSignIn

class LoginView: UIViewController,GIDSignInUIDelegate {
    
    var userEmail : String = ""
    let myNotificationKey = "com.FoodPantryApplication.GoogleSignIn"
    
    @IBOutlet var googleSignInButton: GIDSignInButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setUpNavigationBar()
        //Set the Login Background image
         //view.layer.contents = #imageLiteral(resourceName: "LoginScreenBackground").cgImage
    
        setUpGoogleButton()
        NotificationCenter.default.addObserver(self, selector: #selector(doThisWhenNotify), name: NSNotification.Name(rawValue: myNotificationKey), object: nil)
        
    }
     //self.userProfilePicture.layer.cornerRadius = self.userProfilePicture.frame.size.width / 2
    func setUpNavigationBar()
    {//Use this for setting the logo
//       let navController = navigationController!
//        let image = #imageLiteral(resourceName: "puppy")
//
//        let imageView = UIImageView(image : image)
//
//        let bannerWidth = navController.navigationBar.frame.size.width
//        let bannerHeight = navController.navigationBar.frame.size.height
//
//        let bannerX = bannerWidth / 2 - image.size.width / 2
//        let bannerY = bannerHeight / 2 - image.size.height / 2
//
//        imageView.frame = CGRect(x: 0, y: 0, width: 2, height: 2)
//        imageView.layer.cornerRadius = imageView.frame.size.width / 2
//        imageView.clipsToBounds = true
//        imageView.contentMode = .scaleToFill
//
//        navigationItem.titleView = imageView
        
        
        
    }
    
    @objc func doThisWhenNotify()
    {
        print("We should login now!", "NEXT VIEW PLEASE!")
        self.performSegue(withIdentifier: "PantrySelection", sender: nil)
    }
    
    func setUpGoogleButton()
    {
        let googleButton = GIDSignInButton()
        googleButton.frame = CGRect(x: 60, y: 375, width: view.frame.width - 115, height: 50)
        view.addSubview(googleButton)
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
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
                
                if error == nil
                {
                    print("User has successfully logged in")
                    //Set variable to the local variable. This is set so it can be sent to the next view in the overriden function
                    self.userEmail = (user?.email)!
                    //Change from one view to another.
                    self.performSegue(withIdentifier: "PantrySelection", sender: nil)
                
                }
                    else {
                    
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

        if segue.identifier == "PantrySelection"
        {
            let SecondController = segue.destination as! PantrySelection
            SecondController.userEmail = userEmail
        }
        if segue.identifier == "test"
        {
            return;
        }


    }

    @IBAction func CreateAccountButton(_ sender: UIButton) {
        performSegue(withIdentifier: "test", sender: nil)
    }
    
}
