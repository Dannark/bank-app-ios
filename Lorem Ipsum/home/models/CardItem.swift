//
//  CardItem.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 07/09/21.
//

import Foundation

class CardItem: Codable{
    var clientName: String
    var validDate: String
    var cardNumber: String
    var balanceLimit: String
    
    init(clientName:String, validDate:String, cardNumber:String, balance:String){
        self.clientName = clientName
        self.validDate = validDate
        self.cardNumber = cardNumber
        self.balanceLimit = balance
    }
}
