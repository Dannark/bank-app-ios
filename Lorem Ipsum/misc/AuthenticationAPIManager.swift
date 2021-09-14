//
//  LoginAPIManager.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 14/09/21.
//

import Foundation

class AuthenticationAPIManager {
    static var shared: AuthenticationAPIManager = {
        let instance = AuthenticationAPIManager()
        return instance
    }()
    
    var credentials = AuthenticationModel()
    
    private init(){}
    
    func authenticate(_ cpf: String, _ pass:String, completion: @escaping (Result<AuthenticationModel, Error>) -> Void){
        APIManager.post(params: ["cpf":cpf, "pass":pass]) { result in
            
            switch result{
            case let .success(authentication):
                let auth = self.convertToAuthenticationModel(fromJSON: authentication)
                
                completion(auth)
                
            case let .failure(error):
                print("Erro ao acessar dados do usuario \(error)")
            }
            
        }
    }
    
    private func convertToAuthenticationModel(fromJSON data: Data) -> Result<AuthenticationModel, Error>{
        do{
            let decoder = JSONDecoder()
            let response = try decoder.decode(AuthenticationModel.self, from: data)
            credentials = response
            return .success(response)
        }
        catch{
            return .failure(error)
        }
    }
}
