//
//  Data.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 12..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import Foundation

extension Data{
    func printJSON(){
        if let JSONString = String(data: self, encoding: String.Encoding.utf8){
            print(JSONString)
        }
    }
}
