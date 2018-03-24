//
//  RegistrationVC.swift
//  ENS
//
//  Created by itechnotion-mac1 on 19/03/18.
//  Copyright © 2018 itechnotion-mac1. All rights reserved.
//

import UIKit

class RegistrationVC: UIViewController {

    @IBOutlet weak var viewFullNamee: UIView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewCompany: UIView!
    @IBOutlet weak var viewDesignation: UIView!
    @IBOutlet weak var viewRegister: UIView!
    
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtCompany: UITextField!
    @IBOutlet weak var txtDesignation: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewFullNamee.boderRoundwithShadow()
        viewFullNamee.dropShadow(color: .gray, opacity: 1, offSet: CGSize(width: 1, height: 1), radius: 3, scale: true)
        viewEmail.boderRoundwithShadow()
        viewEmail.dropShadow(color: .gray, opacity: 1, offSet: CGSize(width: 1, height: 1), radius: 3, scale: true)
        viewCompany.boderRoundwithShadow()
        viewCompany.dropShadow(color: .gray, opacity: 1, offSet: CGSize(width: 1, height: 1), radius: 3, scale: true)
        viewDesignation.boderRoundwithShadow()
        viewDesignation.dropShadow(color: .gray, opacity: 1, offSet: CGSize(width: 1, height: 1), radius: 3, scale: true)
        viewRegister.boderRoundwithShadow()
        viewRegister.dropShadow(color: .gray, opacity: 1, offSet: CGSize(width: 1, height: 1), radius: 3, scale: true)
    }
    
    // MARK: - IBAction methods (Click Events)
    
    @IBAction func actionReister(_ sender: Any) {
        if (txtFullName.text?.trimmingCharacters(in: .whitespaces).isEmpty)! || (txtFullName.text?.characters.count)! < 3 {
            self.ShowAlertMessage(title: "", message: "Please enter proper Fullname", buttonText: "OK")
        }else  if (txtEmail.text?.trimmingCharacters(in: .whitespaces).isEmpty)!  ||  !(isValidEmail(testStr: (txtEmail.text!))){
            self.ShowAlertMessage(title: "", message: "Please enter Proper Email Address", buttonText: "OK")
        }else if (txtCompany.text?.trimmingCharacters(in: .whitespaces).isEmpty)! || (txtCompany.text?.characters.count)! < 3 {
            self.ShowAlertMessage(title: "", message: "Please enter Proper Company Name", buttonText: "OK")
        }else if ((txtDesignation.text?.trimmingCharacters(in: .whitespaces).isEmpty)!) || (txtDesignation.text?.characters.count)! < 3 {
            self.ShowAlertMessage(title: "", message: "Please enter Proper Designation", buttonText: "OK")
        } else{
            self.showProgressHUD()
            var parameter = "name=".appending(txtFullName.text!).appending("&email=").appending(txtEmail.text!).appending("&company=").appending(txtCompany.text ?? "")
            if  (!(txtDesignation.text?.trimmingCharacters(in: .whitespaces).isEmpty)!){
                parameter = parameter.appending("&designation=").appending(txtDesignation.text!)
            }
            Webservice.web_registartion.webserviceFetch(parameters: parameter)
            { (parsedData,error,httpResponse) in
                if(error){
                    self.hideProgressHUD()
                    self.ShowAlertMessage(title: "", message: NETWORKMESSAGE, buttonText: "OK")
                }else
                    if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 300{
                        //   let info = parsedData["info"] as! NSDictionary
                        print(parsedData)
                        let info1 = parsedData["status"] as! String
                        print(parsedData)
                        if (info1 == "1"){
                            appDelegate.email = self.txtEmail.text!
                            appDelegate.password = ""
                            self.hideProgressHUD()
                            //appDelegate.name =
                            self.ShowAlertMessage(title: "", message: parsedData["message"] as! String, buttonText: "OK")
                            let viewForHome = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                            self.navigationController?.pushViewController(viewForHome, animated: true)
                        }else{
                            self.hideProgressHUD()
                            self.ShowAlertMessage(title: "", message: parsedData["message"] as! String, buttonText: "OK")
                        }
                }
            }

//            let viewForHome = self.storyboard?.instantiateViewController(withIdentifier: "TabControll")
//            self.navigationController?.pushViewController(viewForHome!, animated: true)
        }
        //   self.ShowAlertMessage(title: "", message: "Under Development", buttonText: "OK")
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

extension RegistrationVC : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Start typing")
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text as NSString? {
            let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
            print(txtAfterUpdate)
            if txtAfterUpdate.characters.count < 2{
                let aSet = NSCharacterSet(charactersIn:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz").inverted
                let compSepByCharInSet = string.components(separatedBy: aSet)
                let numberFiltered = compSepByCharInSet.joined(separator: "")
                return string == numberFiltered
            }else{
                return true
            }
        }else{
            return true
        }
        /*
        print(textField.text!)
        if txtEmail == textField{
            return true
        }else{
            
            let aSet = NSCharacterSet(charactersIn:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            return string == numberFiltered
        }
         */
    }
}

