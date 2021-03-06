//
//  LoginAPIManager.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 01/09/21.
//

import Foundation

class AuthenticationAPIManager: BaseAPICall {
    static var shared: AuthenticationAPIManager = {
        let instance = AuthenticationAPIManager()
        return instance
    }()
    
    private override init(){}
    
    func authenticate(_ cpf: String, _ pass:String, completion: @escaping (AuthenticationModel?, String?) -> Void){
        APIManager.post("login", params: ["cpf":cpf, "pass":pass]) { result, response in
            var errorMsg = "Um erro inesperado aconteceu, favor tente novamente"
            
            if let httpResponse = response as? HTTPURLResponse {
                switch result{
                case let .success(authentication):
                    let auth = self.convertToModel(fromJSON: authentication)
                    
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
}
