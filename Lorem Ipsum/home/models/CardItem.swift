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
    var paymentDay: String
}
