//
//  LoginVC.swift
//  ENS
//
//  Created by itechnotion-mac1 on 19/03/18.
//  Copyright © 2018 itechnotion-mac1. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var viewLogin: UIView!
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewEmail.boderRoundwithShadow()
        viewEmail.dropShadow(color: .gray, opacity: 1, offSet: CGSize(width: 1, height: 1), radius: 3, scale: true)

        viewPassword.boderRoundwithShadow()
        viewPassword.dropShadow(color: .gray, opacity: 1, offSet: CGSize(width: 1, height: 1), radius: 3, scale: true)
        
        viewLogin.boderRoundwithShadow()
        viewLogin.dropShadow(color: .gray, opacity: 1, offSet: CGSize(width: 1, height: 1), radius: 3, scale: true)
    }

    // MARK: - IBAction methods (Click Events)
    
    @IBAction func ationForgotpassword(_ sender: Any) {
        self.ShowAlertMessage(title: "", message: "Under development.", buttonText: "OK")
    }
    
    @IBAction func actionLogin(_ sender: Any) {
        //web_login
        if (txtEmail.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
            self.ShowAlertMessage(title: "", message: "Please enter email address", buttonText: "OK")
        }else if (txtEmail.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
            self.ShowAlertMessage(title: "", message: "Please enter password", buttonText: "OK")
        }else{
            self.showProgressHUD()
            let parameter = "email=".appending(txtEmail.text!).appending("&password=").appending(txtPassword.text!)
            Webservice.web_login.webserviceFetch(parameters: parameter)
            { (parsedData,error,httpResponse) in
                if(error){
                    self.hideProgressHUD()
                    self.ShowAlertMessage(title: "", message: NETWORKMESSAGE, buttonText: "OK")
                }else
                if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 300{
                    //   let info = parsedData["info"] as! NSDictionary
                    let info1 = parsedData["status"] as! String
                    if (info1 == "1"){
                        appDelegate.email = self.txtEmail.text!
                        appDelegate.password = self.txtPassword.text!
                        let data = parsedData["results"] as! NSDictionary
                        appDelegate.location = data["location"] as! String
                        appDelegate.name = data["name"] as! String
                        self.hideProgressHUD()
                        let viewForHome = self.storyboard?.instantiateViewController(withIdentifier: "TabControll")
                        self.navigationController?.pushViewController(viewForHome!, animated: true)
                    }else{
                        self.hideProgressHUD()
                        self.ShowAlertMessage(title: "", message: parsedData["message"] as! String, buttonText: "OK")
                    }
                }
            }
        }
        
//        let viewForHome = self.storyboard?.instantiateViewController(withIdentifier: "TabControll")
//        self.navigationController?.pushViewController(viewForHome!, animated: true)
//         self.ShowAlertMessage(title: "", message: "Under development.", buttonText: "OK")

    }
    
    @IBAction func actionSignup(_ sender: Any) {
        let viewForRegistration = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationVC")
        self.navigationController?.pushViewController(viewForRegistration!, animated: true)
        //self.ShowAlertMessage(title: "", message: "Under development.", buttonText: "OK")
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

extension LoginVC : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
