//
//  DeveloperCell.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 16..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import UIKit

class DeveloperCell: BaseTableCell {
    
    let personLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    override func setupViews() {
        let bg = UIView()
        bg.backgroundColor = #colorLiteral(red: 0.1725490196, green: 0.1725490196, blue: 0.1725490196, alpha: 1)
        selectedBackgroundView = bg
        
        backgroundColor = .clear
        
        textLabel?.textColor = .white
        textLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        
        
        accessoryView = UIImageView(image: #imageLiteral(resourceName: "arrowRightWhite"))
        
        addSubview(personLabel)
        personLabel.setAnchors(top: nil, leading: nil, trailing: trailingAnchor, bottom: nil, topConstant: nil, leadingConstant: nil, trailingConstant: 60, bottomConstant: nil)
        personLabel.center(toVertically: self, toHorizontally: nil)
    }

}
