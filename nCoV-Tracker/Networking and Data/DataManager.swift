//
//  DataManager.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 18..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import Foundation

class DataManager {
    private init() { }
    
    static var shared = DataManager()
    
    func getLocalData(handler: @escaping(_ allData: AllData?) ->() ){
        let url = getDocumentsDirectory().appendingPathComponent("data.json")
        
        do{
            let data = try Data(contentsOf: url)
            let allData = try JSONDecoder().decode(AllData.self, from: data)
            handler(allData)
            return
        }catch{
            handler(nil)
            return
        }
    }
    
    func updateLocalData(allData: AllData){
        if let encodedData = try? JSONEncoder().encode(allData){
            let url = getDocumentsDirectory().appendingPathComponent("data.json")
                do{
                    try encodedData.write(to: url)
                }catch{
                    print(error.localizedDescription)
                }
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
