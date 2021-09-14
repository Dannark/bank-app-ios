//
//  String+Extensions.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 13/09/21.
//

import Foundation

extension String {
    func toPrice(removeDecimal:Bool = false) -> String{
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        
        if let myFloat = Float(self){
            let tipAmount = NSNumber(value:myFloat)
            
            if var formattedTipAmount = formatter.string(from: tipAmount as NSNumber) {
                formattedTipAmount.removeFirst()
                
                if removeDecimal{
                    formattedTipAmount.removeLast(3)

                }
                return formattedTipAmount
            }
        }
        return "-"
    }
    
    func maskWithAsteriscts(amountIndex:Int, ignoreCharanter: Character = " ") -> String {
        var index = amountIndex
        
        return self.reduce("") { sentence, c in
            index -= 1
            return sentence + ((index >= 0 && c != ignoreCharanter) ? "*" : "\(c)")
        }
    }
}
