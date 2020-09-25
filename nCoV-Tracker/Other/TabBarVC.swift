//
//  TabBarVC.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 12..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = UIColor(r: 38, g: 38, b: 38, a: 1)
        tabBar.tintColor = .white
        tabBar.isTranslucent = false

        let mapVC = MapScreenVC()
        mapVC.tabBarItem.image = #imageLiteral(resourceName: "tab0")
        mapVC.title = "MAP VIEW"
    
        let listVC = UINavigationController(rootViewController: ListScreenVC())
        listVC.setNavigationBarHidden(true, animated: false)
        listVC.navigationBar.barStyle = .blackTranslucent
        listVC.tabBarItem.image = #imageLiteral(resourceName: "tab1")
        listVC.title = "LIST VIEW"
        
        let learnVC = UINavigationController(rootViewController: LearnScreenVC())
        learnVC.navigationBar.prefersLargeTitles = true
        learnVC.tabBarItem.image = #imageLiteral(resourceName: "tab2")
        learnVC.title = "LEARN MORE"
        
        let aboutVC = UINavigationController(rootViewController: AboutScreenVC())
        aboutVC.tabBarItem.image = #imageLiteral(resourceName: "tab3")
        aboutVC.title = "ABOUT"
        
        viewControllers = [mapVC, listVC, learnVC, aboutVC]
    }
    
}
