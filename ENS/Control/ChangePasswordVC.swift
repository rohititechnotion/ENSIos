//
//  ChangePasswordVC.swift
//  ENS
//
//  Created by itechnotion-mac1 on 20/03/18.
//  Copyright © 2018 itechnotion-mac1. All rights reserved.
//

import UIKit

class ChangePasswordVC: UIViewController {

    @IBOutlet weak var txtCurrentPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtConfirmNewPassword: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - IBAction Methods (Click events)
    
    @IBAction func actionSaveChanges(_ sender: Any) {
        if (txtCurrentPassword.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
            self.ShowAlertMessage(title: "", message: "Please enter current password", buttonText: "OK")
        }else if (txtNewPassword.text?.trimmingCharacters(in: .whitespaces).isEmpty)! || (txtConfirmNewPassword.text?.characters.count)! < 6{
            self.ShowAlertMessage(title: "", message: "Please enter proper new password (minimum 6 character)", buttonText: "OK")
        }else if (txtConfirmNewPassword.text?.trimmingCharacters(in: .whitespaces).isEmpty)! || (txtConfirmNewPassword.text?.characters.count)! < 6{
            self.ShowAlertMessage(title: "", message: "Please enter proper confirm new password(minimum 6 character)", buttonText: "OK")
        }else if (txtConfirmNewPassword.text != txtNewPassword.text){
            self.ShowAlertMessage(title: "", message: "Password are not match", buttonText: "OK")
        }
        else{
            let parameter = "email=".appending(appDelegate.email).appending("&password=").appending(txtCurrentPassword.text!).appending("&npassword=").appending(txtNewPassword.text!)
            Webservice.web_changepassword.webserviceFetch(parameters: parameter, completion: { (parsedData, error, httpResponse) in
                let info1 = parsedData["status"] as! String
                if (info1 == "1"){
                    self.ShowAlertMessage(title: "", message: parsedData["message"] as! String, buttonText: "OK")
                    self.navigationController?.popViewController(animated: true)
                }else{
                     self.ShowAlertMessage(title: "", message: parsedData["message"] as! String, buttonText: "OK")
                }
            })
        }
    }
    
    // MARK: - user define methods
    
    func ShowAlertMessage(title : String, message: String, buttonText : String)  {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - Extenstion for uitexfield delegate

extension ChangePasswordVC : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
