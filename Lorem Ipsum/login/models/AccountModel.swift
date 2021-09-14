//
//  AccountModel.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 14/09/21.
//

import Foundation

struct AccountModel:Codable {
    var agency: String?
    var number: String?
    var bank: String?
    var balance: String?
    var monthAccumulated: String?
}
