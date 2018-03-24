//
//  UIViewController+HUD.swift
//  FivePGroup
//
//  Created by Nitesh Borad on 21/04/17.
//  Copyright © 2017 Technobrave Pty Ltd. All rights reserved.
//

import UIKit
import PKHUD

extension UIViewController {
    
    private func showInterval() -> TimeInterval {
        return 2.33
    }
    
    func flashHUD(with title:String, completion: ((Bool) -> Void)? = nil) {
        HUD.flash(.label(title), delay: showInterval(), completion: completion)
    }
    
    func flashSuccessHUD(completion: ((Bool) -> Void)? = nil) {
        HUD.flash(.success, delay: showInterval(), completion: completion)
    }
    
    func flashErrorHUD(completion: ((Bool) -> Void)? = nil) {
        HUD.flash(.error, delay: showInterval(), completion: completion)
    }
    
    func showProgressHUD() {
        HUD.show(.progress)
    }
    
    func hideProgressHUD() {
        HUD.hide()
    }
}
