//
//  APIManager.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 14/09/21.
//

import Foundation

enum Endpoint: String {
    case restaurants = "api/1/"
}

struct APIManager {

    static func post(params: Dictionary<String, String>, callback: @escaping (Result<Data, Error>)->Void ){
        var request = URLRequest(url: URL(string: "http://192.168.0.127:3002/api/1/login")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
//            print(response!)
//            let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
            if let data = data{
                callback(.success(data))
            }
            else{
                callback(.failure(error!))
            }
        })
        
        task.resume()
    }
}
