//
//  SearchCell.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 16..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import UIKit

class SearchCell: BaseTableCell {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    let confirmedLabel: UILabel = {
        let label = UILabel()
        label.text = "Confirmed"
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = #colorLiteral(red: 0.8784313725, green: 0.4039215686, blue: 0.4705882353, alpha: 1)
        return label
    }()
    
    let confirmedCounterLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.8784313725, green: 0.4039215686, blue: 0.4705882353, alpha: 1)
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .right
        return label
    }()
    
    let deathsLabel: UILabel = {
        let label = UILabel()
        label.text = "Deaths"
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = #colorLiteral(red: 0.5176470588, green: 0.5176470588, blue: 0.5176470588, alpha: 1)
        return label
    }()
    
    let deathsCounterLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.5176470588, green: 0.5176470588, blue: 0.5176470588, alpha: 1)
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .right
        return label
    }()
    
    let recoveredLabel: UILabel = {
        let label = UILabel()
        label.text = "Confirmed"
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = #colorLiteral(red: 0.2549019608, green: 0.7215686275, blue: 0.6980392157, alpha: 1)
        return label
    }()
    
    let recoveredCounterLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2549019608, green: 0.7215686275, blue: 0.6980392157, alpha: 1)
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .right
        return label
    }()
    
    override func setupViews() {
        backgroundColor = .clear
        
        addSubview(titleLabel)
        titleLabel.setAnchors(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: nil, topConstant: 13, leadingConstant: 40, trailingConstant: 40, bottomConstant: nil)
        
        addSubview(confirmedLabel)
        addSubview(confirmedCounterLabel)
        confirmedLabel.setAnchors(top: titleLabel.bottomAnchor, leading: titleLabel.leadingAnchor, trailing: nil, bottom: nil, topConstant: 7.5, leadingConstant: 0, trailingConstant: nil, bottomConstant: nil)
        confirmedCounterLabel.setAnchors(top: nil, leading: nil, trailing: trailingAnchor, bottom: nil, topConstant: nil, leadingConstant: nil, trailingConstant: 40, bottomConstant: nil)
        confirmedCounterLabel.center(toVertically: confirmedLabel, toHorizontally: nil)
        
        addSubview(deathsLabel)
        addSubview(deathsCounterLabel)
        deathsLabel.setAnchors(top: confirmedLabel.bottomAnchor, leading: titleLabel.leadingAnchor, trailing: nil, bottom: nil, topConstant: 6, leadingConstant: 0, trailingConstant: nil, bottomConstant: nil)
        deathsCounterLabel.setAnchors(top: nil, leading: nil, trailing: trailingAnchor, bottom: nil, topConstant: nil, leadingConstant: nil, trailingConstant: 40, bottomConstant: nil)
        deathsCounterLabel.center(toVertically: deathsLabel, toHorizontally: nil)
        
        addSubview(recoveredLabel)
        addSubview(recoveredCounterLabel)
        recoveredLabel.setAnchors(top: deathsLabel.bottomAnchor, leading: titleLabel.leadingAnchor, trailing: nil, bottom: nil, topConstant: 6, leadingConstant: 0, trailingConstant: nil, bottomConstant: nil)
        recoveredCounterLabel.setAnchors(top: nil, leading: nil, trailing: trailingAnchor, bottom: nil, topConstant: nil, leadingConstant: nil, trailingConstant: 40, bottomConstant: nil)
        recoveredCounterLabel.center(toVertically: recoveredLabel, toHorizontally: nil)
    }
    
    func setupData(searchData: SearchData){
        titleLabel.text = searchData.title
        
        confirmedCounterLabel.text = searchData.cases.delimiter
        deathsCounterLabel.text = searchData.deaths.delimiter
        recoveredCounterLabel.text = searchData.recovered.delimiter
    }

}
