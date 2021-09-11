//
//  HelperExtensions.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 06/09/21.
//

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
}
