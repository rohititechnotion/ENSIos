//
//  AllExtenstion.swift
//  ENS
//
//  Created by itechnotion-mac1 on 19/03/18.
//  Copyright © 2018 itechnotion-mac1. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    func boderRoundwithShadow(){
        self.layer.cornerRadius = 5.0
        //self.layer.borderColor = UIColor.gray.cgColor
        //self.layer.borderWidth = 0.5
        self.clipsToBounds = true
        
       /* self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor;
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 1.0;
        self.layer.shadowOpacity = 0.5
        */
    }
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize.zero//offSet
        layer.shadowRadius = radius
        
        
 //       layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
 //       layer.shouldRasterize = true
  //      layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
}




extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = 0.4
            layer.shadowRadius = shadowRadius
        }
    }
    
}


extension UIColor {
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
}
