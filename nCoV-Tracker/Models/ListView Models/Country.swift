//
//  Country.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 14..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import Foundation

struct Country {
    
    var name: String
    var totalCases: Int
    var totalDeaths: Int
    var totalRecovered: Int
    var areas: [Area]
    var tableData: [Area]
    
    init(name: String, area: Area) {
        self.name = name
        totalCases = area.cases
        totalDeaths = area.deaths
        totalRecovered = area.recovered
        areas = [Area]()
        tableData = [Area]()
        
        if area.name.count > 0 {
            areas.append(area)
        }
    }
    
    mutating func addArea(_ area: Area){
        totalCases += area.cases
        totalDeaths += area.deaths
        totalRecovered += area.recovered
        
        if area.name.count > 0{
            areas.append(area)
        }
    }
    
}
