//
//  Statics.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 17..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import Foundation

class Static {
    
    static var userInteractionsCounter = 2
    
    static var timeToShowAd: Bool {
        get{
            return Static.userInteractionsCounter % 4 == 0
        }
    }
    
    static let bannerID = "ca-app-pub-1502309851026083/7478971285"
    
    static let intersitialID = "ca-app-pub-1502309851026083/8163359387"
    
    static var purchased: Bool {
        get{
            return KeychainWrapper.standard.bool(forKey: "purchase") != nil
        }
    }
    
    static var mapZoom: Float = 5.05207
    static var mapLat = 32.59441100346494
    static var mapLong = 112.59924408048391
}

extension Notification.Name {
    static let removeAds = Notification.Name("removeAds")
}
