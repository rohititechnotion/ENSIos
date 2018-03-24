//
//  ChangeInformationVC.swift
//  ENS
//
//  Created by itechnotion-mac1 on 20/03/18.
//  Copyright © 2018 itechnotion-mac1. All rights reserved.
//

import UIKit

class ChangeInformationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - IBAction Methods (Click events)
    
    @IBAction func actionChangeInformation(_ sender: Any) {
//        let viewControllerforChangeLocation = self.storyboard?.instantiateViewController(withIdentifier: "ChangeLocationVC") as! ChangeLocationVC
//        self.navigationController?.pushViewController(viewControllerforChangeLocation, animated: true)
    }
    
    @IBAction func actionChangeInPassword(_ sender: Any) {
        let viewControllerforChangePassword = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
        self.navigationController?.pushViewController(viewControllerforChangePassword, animated: true)  
    }
}
