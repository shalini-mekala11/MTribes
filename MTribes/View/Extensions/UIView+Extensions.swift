//
//  UIView+Extensions.swift
//  MTribes
//
//  Created by Shalini Mekala on 10/22/17.
//  Copyright © 2017 Shalini Mekala. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable var shadowColor: UIColor? {
        get {
            return UIColor(cgColor:layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
}
