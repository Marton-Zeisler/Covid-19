//
//  SearchDatsa.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 16..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import Foundation

struct SearchData {
    
    var title: String
    var cases: Int
    var deaths: Int
    var recovered: Int
    
    func hasNumbers(worldStatsType: WorldStatsType) -> Bool {
        if worldStatsType == .cases {
            return cases > 0
        }else if worldStatsType == .deaths {
            return deaths > 0
        }else{
            return recovered > 0
        }
    }
    
}
