//
//  BaseAPICall.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 19/09/21.
//

import Foundation


class BaseAPICall{
    var credentials = AuthenticationModel()
    
    func convertToModel(fromJSON data: Data) -> AuthenticationModel?{
        do{
            let decoder = JSONDecoder()
            let response = try decoder.decode(AuthenticationModel.self, from: data)
            credentials = response
            return response
        }
        catch{
            return nil
        }
    }
}
