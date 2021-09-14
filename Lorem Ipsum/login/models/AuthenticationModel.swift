//
//  LoginModel.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 14/09/21.
//

import Foundation

struct AuthenticationModel: Codable{
    var name:String?
    var cpf:String?
    var prekey:String?
    var account: AccountModel?
    var creditcard: CardItem?
    var invoice: InvoiceItem?
}
