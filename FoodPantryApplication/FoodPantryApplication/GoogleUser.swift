//
//  GoogleUser.swift
//  FoodPantryApplication
//
//  Created by Brandon Bigelow on 11/26/17.
//  Copyright © 2017 Brandon Bigelow. All rights reserved.
//

import Foundation

final public class GoogleUser
{
    static public var userEmail : String! = ""
    static public var userProfileImage : URL!
    
    private init(){}
    
   public static func setGoogleUserEmail(userEmail : String!)
    {
        GoogleUser.userEmail = userEmail
    }
    
   public static func getGoogleUserEmail() -> String!
    {
        return userEmail
    }
    
    public static func setGoogleProfileImage(userProfileImage : URL)
    {
        GoogleUser.userProfileImage = userProfileImage
    }
    public static func getGoogleProfileImage() -> URL!
    {
        return userProfileImage
    }
    
}
