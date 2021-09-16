//
//  LoginAPIManager.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 01/09/21.
//

import Foundation

class AuthenticationAPIManager {
    static var shared: AuthenticationAPIManager = {
        let instance = AuthenticationAPIManager()
        return instance
    }()
    
    var credentials = AuthenticationModel()
    
    private init(){}
    
    func authenticate(_ cpf: String, _ pass:String, completion: @escaping (AuthenticationModel?, String?) -> Void){
        APIManager.post("login", params: ["cpf":cpf, "pass":pass]) { result, response in
            var errorMsg = "Um erro inesperado aconteceu, favor tente novamente"
            
            if let httpResponse = response as? HTTPURLResponse {
                switch result{
                case let .success(authentication):
                    let auth = self.convertToAuthenticationModel(fromJSON: authentication)
                    
                    if httpResponse.statusCode == 200{
                        completion(auth, nil)
                        return
                    }
                case let .failure(error):
                    print("Erro ao acessar dados do usuario \(error)")
                }
                if httpResponse.statusCode >= 403{
                    errorMsg = "Credenciais inválida"
                }
            }
            
            completion(nil, errorMsg)
            
        }
    }
    
    func payInvocie(_ cpf: String, _ value:String, completion: @escaping (AuthenticationModel?, String?) -> Void){
        APIManager.post("payInvoice", params: ["cpf":cpf, "value":value]) { result, response in
            var errorMsg = "Um erro inesperado aconteceu, favor tente novamente"
            
            if let httpResponse = response as? HTTPURLResponse {
                switch result{
                case let .success(authentication):
                    let auth = self.convertToAuthenticationModel(fromJSON: authentication)
                    
                    if httpResponse.statusCode == 200{
                        completion(auth, nil)
                        return
                    }
                case let .failure(error):
                    print("Erro ao acessar dados do usuario \(error)")
                }
                if httpResponse.statusCode >= 403{
                    errorMsg = "Saldo insuficiente"
                }
            }
            
            completion(nil, errorMsg)
            
        }
    }
    
    private func convertToAuthenticationModel(fromJSON data: Data) -> AuthenticationModel?{
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
