//
//  AppDelegate.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 12..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import UIKit
import GoogleMaps
import GoogleMobileAds


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey("AIzaSyBQvLRg278VPXraVjgv2WBBt4m5lFkpEr8")
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        IAPManager.shared.startObserving()
        
        // TESTING AD
        //GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = ["028bd128f9caea7a40a26f87d3f5abf7"]
       
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TabBarVC()
        window?.makeKeyAndVisible()
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
        UserDefaults.standard.set(Static.mapZoom, forKey: "zoom")
        UserDefaults.standard.set(Static.mapLat, forKey: "lat")
        UserDefaults.standard.set(Static.mapLong, forKey: "long")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        IAPManager.shared.stopObserving()
    }

}
