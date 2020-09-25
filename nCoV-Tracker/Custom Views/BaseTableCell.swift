//
//  BaseTableCell.swift
//  WeatherApp
//
//  Created by Marton Zeisler on 2019. 11. 24..
//  Copyright © 2019. Marton Zeisler. All rights reserved.
//

import UIKit

class BaseTableCell: UITableViewCell{
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews(){

    }
    
}
