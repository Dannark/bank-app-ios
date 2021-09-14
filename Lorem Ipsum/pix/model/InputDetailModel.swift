//
//  InputDetailModel.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 12/09/21.
//

import Foundation

class InputDetailModel{
    var title: String
    var sutitlePlaceholder: String
    var minLength: Int
    var maxLength: Int
    var allowedCharacters: String
    var passwordMask: Bool
    
    init(title:String, sutitlePlaceholder:String, minLength: Int, maxLength:Int = 10, allowedCharacters:String = "0123456788.", passwordMask:Bool = false){
        self.title = title
        self.sutitlePlaceholder = sutitlePlaceholder
        self.maxLength = maxLength
        self.minLength = minLength
        self.allowedCharacters = allowedCharacters
        self.passwordMask = passwordMask
    }
}
