//
//  Invoice.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 14/09/21.
//

import Foundation

struct InvoiceItem: Codable{
    var id:String
    var value:String
    var dueDate:String
    var paid:String
}

extension InvoiceItem {
    func valueToBePaid() -> String {
        return String((Int(value) ?? 0) - (Int(paid) ?? 0))
    }
}
