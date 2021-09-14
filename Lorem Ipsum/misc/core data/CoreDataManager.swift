//
//  Api.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 14/09/21.
//

import Foundation

struct CoreDataManager {
    static var shared: CoreDataManager = {
        let instance = CoreDataManager()
        return instance
    }()
    
    private init() {
        
    }
    
    func authenticate(_ cpf: String, pass:String){
        APIManager.post(params: ["cpf":cpf, "pass":pass]) { result in
            print(result)
        }
    }
    
}
