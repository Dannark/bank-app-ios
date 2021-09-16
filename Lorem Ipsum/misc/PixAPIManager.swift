//
//  PixAPIManager.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 15/09/21.
//

import Foundation


class PixAPIManager {
    static var shared: PixAPIManager = {
        let instance = PixAPIManager()
        return instance
    }()
    
    var credentials = AuthenticationModel()
    
    private init(){}
    
    func fetchPixKey(_ key:String, _ value: String, completion: @escaping (AuthenticationModel?, String?) -> Void){
        APIManager.post("pixkey", params: [key:value]) { result, response in
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
                if httpResponse.statusCode == 404{
                    errorMsg = "Chave pix não encontrada"
                }
            }
            
            completion(nil, errorMsg)
            
        }
    }
    
    func sendPix(_ sendTo:String, _ value:String, _ from:String, completion: @escaping (AuthenticationModel?, String?) -> Void){
        APIManager.post("sendpix", params: ["sendTo":sendTo, "value":value, "from":from]) { result, response in
            var errorMsg = "Um erro inesperado aconteceu, favor tente novamente"
            
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse)
                switch result{
                case let .success(authentication):
                    let auth = self.convertToAuthenticationModel(fromJSON: authentication)
                    
                    if httpResponse.statusCode == 200{
                        completion(auth, nil)
                        return
                    }
                case let .failure(error):
                    print("Erro ao acessar dados da transação do pix: \(error)")
                }
                if httpResponse.statusCode == 403{
                    errorMsg = "Saldo insuficiente"
                }
                else if httpResponse.statusCode == 404{
                    errorMsg = "Chave PIX não encontrada"
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
