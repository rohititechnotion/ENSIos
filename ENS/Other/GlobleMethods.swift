//
//  GlobleMethods.swift
//  ENS
//
//  Created by itechnotion-mac1 on 20/03/18.
//  Copyright © 2018 itechnotion-mac1. All rights reserved.
//

import Foundation
import UIKit

func isValidEmail(testStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}

