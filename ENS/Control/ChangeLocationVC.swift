//
//  ChangeLocationVC.swift
//  ENS
//
//  Created by itechnotion-mac1 on 20/03/18.
//  Copyright © 2018 itechnotion-mac1. All rights reserved.
//

import UIKit

class ChangeLocationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
// MARK: - IBAction methods (Click events)
    
    @IBAction func actionChangeLocation(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
