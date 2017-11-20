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

class PantrySelection : UIViewController{

    var userEmail = String()
    
    @IBOutlet var welcomeBanner: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        welcomeBanner.text = "Welcome " + userEmail
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
