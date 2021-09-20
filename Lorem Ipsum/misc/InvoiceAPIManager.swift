//
//  InvoiceAPIManager.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 19/09/21.
//

import Foundation

class InvoiceAPIManager: BaseAPICall {
    static var shared: InvoiceAPIManager = {
        let instance = InvoiceAPIManager()
        return instance
    }()
    
    private override init(){}

    func payInvocie(_ cpf: String, _ invoice: InvoiceItem, completion: @escaping (AuthenticationModel?, String?) -> Void){
        APIManager.post("payInvoice", params: ["cpf":cpf, "value":invoice.value, "dueDate":invoice.dueDate]) { result, response in
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
                    errorMsg = "Saldo insuficiente"
                }
            }
            
            completion(nil, errorMsg)
            
        }
    }
}
