//
//  Util.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 13/09/21.
//

import Foundation
import UIKit

class Presets{
    static var CPF_CHARS = "0123456789.-/"
    static var NUMERIC_CHARS = "0123456789"
    static var EMAIL_CHARS = "qwertyuiopasdfghjklçzxcvbnm_.0123456789@"
    static var ANY = "ANY"
}

struct Utils {
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
}
