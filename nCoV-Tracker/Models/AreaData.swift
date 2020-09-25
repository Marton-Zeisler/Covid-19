//
//  AreaData.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 12..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import Foundation

class AreaData: Codable{
    
    var area: String
    var country: String?
    var lat: Double?
    var long: Double?
    var cases: Int
    var deaths: Int
    var recovered: Int
    
    var formattedTitle: String {
        var text = ""
        
        if area.count > 0{
            text += area
        }
        
        if let countryText = country{
            if text.count > 0 {
                text += ", \(countryText)"
            }else{
                text = countryText
            }
        }
        
        return text
    }
    
    enum RootKeys: String, CodingKey{
        case area = "Province"
        case country = "Country"
        case lat = "Lat"
        case long = "Long"
        case cases = "Confirmed"
        case deaths = "Deaths"
        case recovered = "Recovered"
    }
    
    func encode(to encoder: Encoder) throws {
        var rootContainer = encoder.container(keyedBy: RootKeys.self)
        try rootContainer.encode(area, forKey: .area)
        try rootContainer.encodeIfPresent(country, forKey: .country)
        try rootContainer.encodeIfPresent(lat, forKey: .lat)
        try rootContainer.encodeIfPresent(long, forKey: .long)
        try rootContainer.encode(cases, forKey: .cases)
        try rootContainer.encode(deaths, forKey: .deaths)
        try rootContainer.encode(recovered, forKey: .recovered)
    }
    
    required init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootKeys.self)
        area = try rootContainer.decodeIfPresent(String.self, forKey: .area) ?? ""
        country = try rootContainer.decodeIfPresent(String.self, forKey: .country)
        
        if country == "US" {
            country = "United States"
        }else if country == "UK"{
            country = "United Kingdom"
        }
        
        if let country = country, area == country{
            area = ""
        }
        
        lat = try rootContainer.decodeIfPresent(Double.self, forKey: .lat)
        long = try rootContainer.decodeIfPresent(Double.self, forKey: .long)
        cases = try rootContainer.decodeIfPresent(Int.self, forKey: .cases) ?? 0
        deaths = try rootContainer.decodeIfPresent(Int.self, forKey: .deaths) ?? 0
        recovered = try rootContainer.decodeIfPresent(Int.self, forKey: .recovered) ?? 0
    }
}
