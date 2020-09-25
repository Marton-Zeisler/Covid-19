//
//  BaseTableHeaderFooterView.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 13..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import UIKit

class BaseTableHeaderFooterView: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews(){
        
    }

}
