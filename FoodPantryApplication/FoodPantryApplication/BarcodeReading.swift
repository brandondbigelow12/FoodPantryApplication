//
//  BarcodeReading.swift
//  FoodPantryApplication
//
//  Created by Brandon Bigelow on 11/21/17.
//  Copyright © 2017 Brandon Bigelow. All rights reserved.
//

import Foundation
import Alamofire

class BarcodeReading
{
    func SendBarcodeRequest(barcode : String!)
    {
        let url = URL(string: barcode)
        
        Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                //to get status code
                if let status = response.response?.statusCode {
                    switch(status){
                    case 201:
                        print("example success")
                    default:
                        print("error with response status: \(status)")
                    }
                }
                //to get JSON return value
                if let result = response.result.value {
                    let JSON = result as! NSDictionary
                    print(JSON)
                }
                
        }
        
    }
}
