//
//  WebService.swift
//  Prueba
//
//  Created by Pepe Ruiz on 17/01/23.
//

import Foundation

class WebService {
    func search(query: String,
                page: Int,
                completion: @escaping (ResponseModel?) -> ()) {
        let url: String = "https://00672285.us-south.apigw.appdomain.cloud/demo-gapsi/search?&query=\(query)&page=\(page)"
        
        guard let url = URL(string: url) else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("adb8204d-d574-4394-8c1a-53226a40876e",
                         forHTTPHeaderField: "X-IBM-Client-Id")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Error").")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            let info = try? JSONDecoder().decode(ResponseModel.self, from: data)
            print(info)
            DispatchQueue.main.async {
                info == nil ? completion(nil) : completion(info)
            }
        }.resume()
        
    }
    
}
