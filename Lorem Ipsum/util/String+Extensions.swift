//
//  String+Extensions.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 13/09/21.
//

import Foundation

extension String {
    func toPrice() -> String{
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        
        if let myInteger = Int(self) {
            let tipAmount = NSNumber(value:myInteger)
            
            if var formattedTipAmount = formatter.string(from: tipAmount as NSNumber) {
                formattedTipAmount.removeFirst()
                return formattedTipAmount
            }
        }
        return "-"
    }
}
