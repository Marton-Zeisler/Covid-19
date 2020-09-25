//
//  ListData.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 14..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import Foundation

class ListData {
    
    static var shared = ListData()
    
    private var casesCountries: [Country]
    private var deathsCountries: [Country]
    private var recoveredCountries: [Country]
    
    var worldWideCases: Int
    var worldWideDeaths: Int
    var worldWideRecovered: Int
    
    private var countries: [String: (casesIndex: Int?, deathsIndex: Int?, recoveredIndex: Int?)]
    
    private var openSectionIndexCases: Int?
    private var openSectionIndexDeaths: Int?
    private var openSectionIndexRecovered: Int?
    
    var searchData: [SearchData]
    var searchDataCountryIndexes: [String: Int]
    
    var updateDateString: String?
    
    private init() {
        casesCountries = [Country]()
        deathsCountries = [Country]()
        recoveredCountries = [Country]()
        
        worldWideCases = 0
        worldWideDeaths = 0
        worldWideRecovered = 0
        
        countries = [String: (Int?, Int?, Int?)]()
        
        searchData = [SearchData]()
        searchDataCountryIndexes = [String: Int]()
    }
    
    func reset() {
        casesCountries.removeAll()
        deathsCountries.removeAll()
        recoveredCountries.removeAll()
        
        worldWideCases = 0
        worldWideDeaths = 0
        worldWideRecovered = 0
        
        countries.removeAll()
        
        searchData.removeAll()
        searchDataCountryIndexes.removeAll()
    }
    
    func getOpenSectionIndex(for worldStatsType: WorldStatsType) -> Int?{
        if worldStatsType == .cases{
            return openSectionIndexCases
        }else if worldStatsType == .deaths{
            return openSectionIndexDeaths
        }else{
            return openSectionIndexRecovered
        }
    }
    
    func setOpenSectionIndex(for worldStatsType: WorldStatsType, index: Int?){
        if worldStatsType == .cases{
            openSectionIndexCases = index
        }else if worldStatsType == .deaths{
            openSectionIndexDeaths = index
        }else{
            openSectionIndexRecovered = index
        }
    }
    
    func getCountries(for worldStatsType: WorldStatsType) -> [Country] {
        if worldStatsType == .cases{
            return casesCountries
        }else if worldStatsType == .deaths{
            return deathsCountries
        }else{
            return recoveredCountries
        }
    }
    
    func addTableData(section: Int, worldStatsType: WorldStatsType){
        if worldStatsType == .cases{
            casesCountries[section].tableData.append(contentsOf: casesCountries[section].areas)
        }else if worldStatsType == .deaths{
            deathsCountries[section].tableData.append(contentsOf: deathsCountries[section].areas)
        }else if worldStatsType == .recovered{
            recoveredCountries[section].tableData.append(contentsOf: recoveredCountries[section].areas)
        }
    }
    
    func removeTableData(section: Int, worldStatsType: WorldStatsType){
        if worldStatsType == .cases{
            casesCountries[section].tableData.removeAll()
        }else if worldStatsType == .deaths{
            deathsCountries[section].tableData.removeAll()
        }else if worldStatsType == .recovered{
            recoveredCountries[section].tableData.removeAll()
        }
    }
    
    func addAreaData(_ areaData: AreaData){
        guard let countryName = areaData.country else { return }
        
        // Adding search data - city
        if areaData.area.count > 0{
            searchData.append(SearchData(title: areaData.area, cases: areaData.cases, deaths: areaData.deaths, recovered: areaData.recovered))
        }
        
        // Adding search data - country
        if let searchDataCountryIndex = searchDataCountryIndexes[countryName]{
            searchData[searchDataCountryIndex].cases += areaData.cases
            searchData[searchDataCountryIndex].deaths += areaData.deaths
            searchData[searchDataCountryIndex].recovered += areaData.recovered
        }else{
            searchData.append(SearchData(title: countryName, cases: areaData.cases, deaths: areaData.deaths, recovered: areaData.recovered))
            searchDataCountryIndexes[countryName] = searchData.count - 1
        }
        
        
        worldWideCases += areaData.cases
        worldWideDeaths += areaData.deaths
        worldWideRecovered += areaData.recovered
        
        let countryIndexes = countries[countryName]
        
        let area = Area(areaData: areaData)
    
        if let countryIndexes = countryIndexes{
            // Checking if area has any cases, if yes, then add it to its country if its country has cases already or create new country for cases category
            if areaData.cases > 0{
                if let casesIndex = countryIndexes.casesIndex{
                    // The city's country is already defined
                    casesCountries[casesIndex].addArea(area)
                }else{
                    // First city in the country to have cases
                    casesCountries.append(Country(name: countryName, area: area))
                    countries[countryName]?.casesIndex = casesCountries.count - 1
                }
            }
            
            if areaData.deaths > 0{
                if let deathsIndex = countryIndexes.deathsIndex{
                    // The city's country is already defined
                    deathsCountries[deathsIndex].addArea(area)
                }else{
                    // First city in the country to have deaths
                    deathsCountries.append(Country(name: countryName, area: area))
                    countries[countryName]?.deathsIndex = deathsCountries.count - 1
                }
            }
            
            if areaData.recovered > 0{
                if let recoveredIndex = countryIndexes.recoveredIndex{
                    // The city's country is already defined
                    recoveredCountries[recoveredIndex].addArea(area)
                }else{
                    // First city in the country to have recovered
                    recoveredCountries.append(Country(name: countryName, area: area))
                    countries[countryName]?.recoveredIndex = recoveredCountries.count - 1
                }
            }
        }else{
            // New country
            let country = Country(name: countryName, area: area)
            var indexes: (casesIndex: Int?, deathsIndex: Int?, recoveredIndex: Int?) = (nil, nil, nil)
    
            if country.totalCases > 0 {
                casesCountries.append(country)
                indexes.casesIndex = casesCountries.count - 1
            }
            
            if country.totalDeaths > 0 {
                deathsCountries.append(country)
                indexes.deathsIndex = deathsCountries.count - 1
            }
            
            if country.totalRecovered > 0 {
                recoveredCountries.append(country)
                indexes.recoveredIndex = recoveredCountries.count - 1
            }
            
            countries[countryName] = indexes
        }
    }
    
    func sortData(){
        ListData.shared.casesCountries.sort { $0.totalCases >= $1.totalCases }
        for index in 0..<ListData.shared.casesCountries.count {
            ListData.shared.casesCountries[index].areas.sort { $0.cases >= $1.cases }
        }
        
        ListData.shared.deathsCountries.sort { $0.totalDeaths >= $1.totalDeaths }
        for index in 0..<ListData.shared.deathsCountries.count {
            ListData.shared.deathsCountries[index].areas.sort { $0.deaths >= $1.deaths }
        }
        
        ListData.shared.recoveredCountries.sort { $0.totalRecovered >= $1.totalRecovered }
        for index in 0..<ListData.shared.recoveredCountries.count {
            ListData.shared.recoveredCountries[index].areas.sort { $0.recovered >= $1.recovered }
        }
    }

}
