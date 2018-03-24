//
//  WebserviceManager.swift
//  ENS
//
//  Created by itechnotion-mac1 on 20/03/18.
//  Copyright © 2018 itechnotion-mac1. All rights reserved.
//

import UIKit
import Foundation

let appDelegate = UIApplication.shared.delegate as! AppDelegate

enum Webservice : String{
    case web_login =                "/login.php"
    case web_registartion =         "/register.php"
    case web_changepassword =       "/changepwd.php"
    case web_group =                "/fetch_group.php"
    case web_category =             "/fetch_category.php"
    case web_sub_category =         "/fetch_subcategory.php"
    case web_person =               "/fetch_person.php"
    case web_search =               "/search.php"
    
    func webserviceFetch( parameters: String, completion:(([String:Any],(Bool),(HTTPURLResponse))->())?) {
        let urlPath = appDelegate.WEBPATH.appending(self.rawValue)
        
        let url = NSURL(string:urlPath as String)
        print(url!)
        
        var request = URLRequest(url: url! as URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        //"token_id=".appending(appDelegate.TOKEN as String).appending(parameters) as NSString
        //print("Token \(appDelegate.TOKEN)")
        request.httpBody = parameters.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            let httpResponse = response as? HTTPURLResponse
            print("error \(String(describing: httpResponse?.statusCode))")
            if error != nil {
                DispatchQueue.main.async {
                    let parsedData:[String:Any] = [  // ["b": 12]
                        "A":"A",
                        ]
                    completion?(parsedData,true,HTTPURLResponse())
                }
            }
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    DispatchQueue.main.async {
                        completion?(parsedData, false,httpResponse!)
                    }
                }
            }
        }
        task.resume()
    }

    
}

