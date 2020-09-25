//
//  Area.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 14..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import Foundation

struct Area {
    
    var name: String
    var cases: Int
    var deaths: Int
    var recovered: Int
    
    init(areaData: AreaData) {
        name = areaData.area
        cases = areaData.cases
        deaths = areaData.deaths
        recovered = areaData.recovered
    }
    
}
