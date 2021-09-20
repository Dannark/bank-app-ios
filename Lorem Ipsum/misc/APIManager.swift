//
//  APIManager.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 14/09/21.
//

import Foundation

struct APIManager {
    static var isOffline = true
    static var SERVER_PATH = isOffline ? "http://192.168.0.127:3002" : "http://ec2-18-224-184-195.us-east-2.compute.amazonaws.com:3002"

    static func post(_ endpoint:String, params: Dictionary<String, String>, callback: @escaping (Result<Data, Error>, _ res: URLResponse?)->Void ){
        var request = URLRequest(url: URL(string: "\(SERVER_PATH)/api/v1/\(endpoint)")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
//            print(response!)
//            let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
            
            if let data = data{
                callback(.success(data), response)
            }
            else{
                callback(.failure(error!), response)
            }
        })
        
        task.resume()
    }
}
