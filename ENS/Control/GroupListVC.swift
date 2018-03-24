//
//  GroupListVC.swift
//  ENS
//
//  Created by itechnotion-mac1 on 19/03/18.
//  Copyright © 2018 itechnotion-mac1. All rights reserved.
//

import UIKit
import MessageUI

class GroupListVC: UIViewController {
    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var tableGroupList: UITableView!
    @IBOutlet weak var lblCategory: UILabel!
    
    var categoryName = String()
    var groupName = String()
    var personList = [PersonData]()
    var subCategoryID = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showProgressHUD()
        lblCategory.text = categoryName
        lblCategoryName.text =  groupName
        
        self.tableGroupList.rowHeight = UITableViewAutomaticDimension
        self.tableGroupList.estimatedRowHeight = 50
        
        self.tableGroupList.register(UINib(nibName: "GroupListCell", bundle: nil), forCellReuseIdentifier: "cell")

        self.getPerson()
    }
// MARK: - user define methods
    func getPerson(){
        let parameter = "subcategory_id=".appending(subCategoryID)
        Webservice.web_person.webserviceFetch(parameters: parameter)
        { (parsedData,error,httpResponse) in
            if(error){
                self.hideProgressHUD()
                self.ShowAlertMessage(title: "", message: NETWORKMESSAGE, buttonText: "OK")
            }else
                if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 300{
                     let info = parsedData["result"] as! NSDictionary
                    self.personList = [PersonData]()
                    let info1 = info["persons"] as! [JSONType]
                    
                    let person = info1.flatMap(PersonData.init)
                    self.personList.append(contentsOf: person)

                    self.tableGroupList.reloadData()
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                        self.hideProgressHUD()
                        // Put your code which should be executed with a delay here
                    })
                }else if httpResponse.statusCode == 401{
                    self.hideProgressHUD()
                    var Error : String!
                    Error = parsedData["message"] as! String
                    self.ShowAlertMessage(title: "", message: Error, buttonText: "OK")
            }
        }
    }
    
    func callNumber(rowNumber:Int) {
        if self.personList[rowNumber].contact_number == ""{
            self.ShowAlertMessage(title: "", message: "No number available for call", buttonText: "OK")
        }else{
            print("Call : = \(self.personList[rowNumber].contact_number ?? "")")
            //if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            //    let application:UIApplication = UIApplication.shared
            //    if (application.canOpenURL(phoneCallURL)) {
             //       application.open(phoneCallURL, options: [:], completionHandler: nil)
              //  }
            //}
        }
        
       
    }
    func messageNumber(rowNumber:Int) {
        if self.personList[rowNumber].contact_number == ""{
            self.ShowAlertMessage(title: "", message: "No number available for message", buttonText: "OK")
        }
        print("Message : = \(self.personList[rowNumber].contact_number ?? "")")
    }
    
    func emailNumber(rowNumber:Int) {
        if self.personList[rowNumber].email == ""{
            self.ShowAlertMessage(title: "", message: "No email address available for email", buttonText: "OK")
        }else{
            print("EMAIL : = \(self.personList[rowNumber].email ?? "")")
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
// MARK: - Extenstion For UITableview Delegate and DataSourse

extension GroupListVC : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! GroupListCell
        cell.row = indexPath.row
        cell.lblName.text = personList[indexPath.row].name
        cell.lblPosition.text = personList[indexPath.row].position ?? "Position"
        cell.lblLocation.text = personList[indexPath.row].location_name
        let url = URL(string: personList[indexPath.row].img!)
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            cell.imgProfile.boderRoundwithShadow()
            cell.imgProfile.image = UIImage(data: imageData)
        }else  {
            cell.imgProfile.image = #imageLiteral(resourceName: "default")
        }

        
//        cell.imgProfile.image = personList[indexPath.row].img
        cell.onEmaiClick = { (rowCount) in
            self.emailNumber(rowNumber: rowCount)
        }
        
        cell.onMessageClick = { (rowCount) in
            self.messageNumber(rowNumber: rowCount)
        }
        cell.onCallClick = { (rowCount) in
            self.callNumber(rowNumber: rowCount)
        }
        return cell
    }
    
}

// MARK: - Extenstion For MFMessage ComposeViewController Delegate

extension GroupListVC : MFMessageComposeViewControllerDelegate {
    
    @IBAction func sendText(sender: UIButton) {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "Message Body"
            controller.recipients = ["997999999"]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
    }

    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismiss(animated: true, completion: nil)
    }
}


// MARK: - Extenstion For MFMessage ComposeViewController Delegate

extension GroupListVC : MFMailComposeViewControllerDelegate{
    func sendEmail() {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        // Configure the fields of the interface.
        composeVC.setToRecipients(["address@example.com"])
        composeVC.setSubject("Hello!")
        composeVC.setMessageBody("Hello this is my message body!", isHTML: false)
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        // Check the result or perform other tasks.
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
}

