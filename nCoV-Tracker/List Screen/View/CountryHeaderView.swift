//
//  CountryHeaderView.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 13..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import UIKit

class CountryHeaderView: BaseTableHeaderFooterView {
    
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
        return view
    }()
    
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2705882353, green: 0.2705882353, blue: 0.2705882353, alpha: 1)
        view.layer.cornerRadius = 8
        return view
    }()
    
    let countryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    let counterLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.8784313725, green: 0.4039215686, blue: 0.4705882353, alpha: 1)
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .right
        return label
    }()
    
    let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "downArrow")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var sectionIndex: Int?
    
    override func setupViews() {
        backgroundView = bgView
        
        addSubview(mainView)
        mainView.setAnchors(top: nil, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, topConstant: nil, leadingConstant: 18, trailingConstant: 18, bottomConstant: 0)
        mainView.setAnchorSize(width: nil, height: 54)
        
        mainView.addSubview(arrowImageView)
        arrowImageView.setAnchors(top: nil, leading: nil, trailing: mainView.trailingAnchor, bottom: nil, topConstant: nil, leadingConstant: nil, trailingConstant: 20, bottomConstant: nil)
        arrowImageView.center(toVertically: mainView, toHorizontally: nil)
        arrowImageView.setContentCompressionResistancePriority(.required, for: .horizontal)//
        
        mainView.addSubview(counterLabel)
        counterLabel.setAnchors(top: nil, leading: nil, trailing: arrowImageView.leadingAnchor, bottom: nil, topConstant: nil, leadingConstant: nil, trailingConstant: 20, bottomConstant: nil)
        counterLabel.center(toVertically: mainView, toHorizontally: nil)
        counterLabel.sizeToFit()
        counterLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
  
        mainView.addSubview(countryLabel)
        countryLabel.setAnchors(top: nil, leading: mainView.leadingAnchor, trailing: nil, bottom: nil, topConstant: nil, leadingConstant: 20, trailingConstant: nil, bottomConstant: nil)
        countryLabel.trailingAnchor.constraint(lessThanOrEqualTo: counterLabel.leadingAnchor, constant: -20).isActive = true
        countryLabel.center(toVertically: mainView, toHorizontally: nil)
    }
    
    func setupData(country: Country, worldStatsType: WorldStatsType){
        countryLabel.text = country.name

        if worldStatsType == .cases{
            counterLabel.text = country.totalCases.delimiter
        }else if worldStatsType == .deaths{
            counterLabel.text = country.totalDeaths.delimiter
        }else{
            counterLabel.text = country.totalRecovered.delimiter
        }
        
        setColor(worldStatsType: worldStatsType)
        
        arrowImageView.isHidden = country.areas.isEmpty
    }
    
    func setColor(worldStatsType: WorldStatsType){
        counterLabel.textColor = worldStatsType.getColor()
    }
    
    func showOpen(){
        arrowImageView.image = #imageLiteral(resourceName: "upArrow")
        mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func showClosed(){
        arrowImageView.image = #imageLiteral(resourceName: "downArrow")
        mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
}
