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
    var limitPix:String?
    var account: AccountModel?
    var creditcard: CardItem?
    var invoices: [InvoiceItem]?
}

extension AuthenticationModel {
    func getLastPendingInvoice() -> InvoiceItem?{
        return invoices?.filter{ invoice in
            invoice.paid == "0"
        }.first
    }
}
