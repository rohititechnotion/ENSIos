//
//  SettingsVC.swift
//  ENS
//
//  Created by itechnotion-mac1 on 20/03/18.
//  Copyright © 2018 itechnotion-mac1. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var imgLocation: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgLocation.tintColor = .white
        lblName.text = appDelegate.name
        lblEmail.text = appDelegate.email
        
    }

    // MARK: - IBAction MEthods (Click Events)
    
    @IBAction func actionChangeInformation(_ sender: Any) {
        let viewControllForChangeInformation = self.storyboard?.instantiateViewController(withIdentifier: "ChangeInformationVC") as! ChangeInformationVC
        self.navigationController?.pushViewController(viewControllForChangeInformation, animated: true)
    }
  
    @IBAction func actionLogout(_ sender: Any) {
        let alertController = UIAlertController(title: "", message: "Are you sure you want to logot?", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            NSLog("Logout sucessfully")
            let viewLoggin = self.storyboard?.instantiateViewController(withIdentifier: "NavigationLoggin") as! NavigationLoggin
            self.navigationController?.present(viewLoggin, animated: true, completion: nil)
//            self.navigationController?.pushViewController(viewLoggin, animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
}
