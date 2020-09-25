//
//  Network.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 12..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import Foundation

class Network {
    
    static let shared = Network()
    
    private init() { }
    
    func downloadData(handler: @escaping(_ allData: AllData?) ->() ){
        guard let url = URL(string: URLBases.dataURL) else {
            handler(nil)
            return
        }

        let request = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = false
        
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        let urlSession = URLSession(configuration: config)
        
        urlSession.dataTask(with: request) { (data, response, error) in
            if let error = error{
                print(error.localizedDescription)
                handler(nil)
                return
            }

            guard let data = data else {
                handler(nil)
                return
            }

            do{
                let allData = try JSONDecoder().decode(AllData.self, from: data)
                handler(allData)
                return
            }catch let error{
                print(error.localizedDescription)
                handler(nil)
                return
            }
        }.resume()
    }
    
}
