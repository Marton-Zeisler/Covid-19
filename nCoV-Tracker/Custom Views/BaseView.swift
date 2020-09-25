//
//  BaseView.swift
//  WeatherApp
//
//  Created by Marton Zeisler on 2019. 11. 24..
//  Copyright © 2019. Marton Zeisler. All rights reserved.
//

import UIKit

class BaseView: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews(){
        
    }
    
}
