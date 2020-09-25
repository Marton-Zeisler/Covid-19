//
//  DetailMarkerView.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 12..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import UIKit

class DetailMarkerView: BaseView {

    let areaLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2235294118, green: 0.2235294118, blue: 0.2235294118, alpha: 1)
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 0
        return label
    }()
    
    let seperatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
        return view
    }()
    
    let confirmedTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Confirmed"
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = #colorLiteral(red: 0.7568627451, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        return label
    }()
    
    let deathsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Deaths"
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = #colorLiteral(red: 0.5176470588, green: 0.5176470588, blue: 0.5176470588, alpha: 1)
        return label
    }()
    
    let recoveredTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Recovered"
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = #colorLiteral(red: 0.2549019608, green: 0.7215686275, blue: 0.6980392157, alpha: 1)
        return label
    }()
    
    let confirmedLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = #colorLiteral(red: 0.7568627451, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        label.textAlignment = .right
        return label
    }()
    
    let deathsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = #colorLiteral(red: 0.5176470588, green: 0.5176470588, blue: 0.5176470588, alpha: 1)
        label.textAlignment = .right
        return label
    }()
    
    let recoveredLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = #colorLiteral(red: 0.2549019608, green: 0.7215686275, blue: 0.6980392157, alpha: 1)
        label.textAlignment = .right
        return label
    }()
    
    override func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        setShadows(shadowColor: #colorLiteral(red: 0.2117647059, green: 0.2117647059, blue: 0.2117647059, alpha: 1), shadowOpacity: 0.5, shadowOffset: CGPoint(x: 0, y: 2), shadowBlur: 10)
        
        addSubview(areaLabel)
        areaLabel.setAnchors(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: nil, topConstant: 20, leadingConstant: 16, trailingConstant: 16, bottomConstant: nil)
        
        addSubview(seperatorLineView)
        seperatorLineView.setAnchors(top: areaLabel.bottomAnchor, leading: areaLabel.leadingAnchor, trailing: trailingAnchor, bottom: nil, topConstant: 12, leadingConstant: 0, trailingConstant: 16, bottomConstant: nil)
        seperatorLineView.setAnchorSize(width: nil, height: 1)
        
        addSubview(confirmedTitleLabel)
        confirmedTitleLabel.setAnchors(top: seperatorLineView.bottomAnchor, leading: seperatorLineView.leadingAnchor, trailing: nil, bottom: nil, topConstant: 13, leadingConstant: 0, trailingConstant: nil, bottomConstant: nil)
        
        addSubview(deathsTitleLabel)
        deathsTitleLabel.setAnchors(top: confirmedTitleLabel.bottomAnchor, leading: confirmedTitleLabel.leadingAnchor, trailing: nil, bottom: nil, topConstant: 8, leadingConstant: 0, trailingConstant: nil, bottomConstant: nil)
        
        addSubview(recoveredTitleLabel)
        recoveredTitleLabel.setAnchors(top: deathsTitleLabel.bottomAnchor, leading: deathsTitleLabel.leadingAnchor, trailing: nil, bottom: nil, topConstant: 8, leadingConstant: 0, trailingConstant: nil, bottomConstant: nil)
        
        addSubview(confirmedLabel)
        confirmedLabel.setAnchors(top: nil, leading: confirmedTitleLabel.trailingAnchor, trailing: seperatorLineView.trailingAnchor, bottom: nil, topConstant: nil, leadingConstant: 16, trailingConstant: 0, bottomConstant: 0)
        confirmedLabel.center(toVertically: confirmedTitleLabel, toHorizontally: nil)
        
        addSubview(deathsLabel)
        deathsLabel.setAnchors(top: nil, leading: deathsTitleLabel.trailingAnchor, trailing: confirmedLabel.trailingAnchor, bottom: nil, topConstant: nil, leadingConstant: 16, trailingConstant: 0, bottomConstant: 0)
        deathsLabel.center(toVertically: deathsTitleLabel, toHorizontally: nil)
        
        addSubview(recoveredLabel)
        recoveredLabel.setAnchors(top: nil, leading: recoveredTitleLabel.trailingAnchor, trailing: deathsLabel.trailingAnchor, bottom: nil, topConstant: nil, leadingConstant: 16, trailingConstant: 0, bottomConstant: 0)
        recoveredLabel.center(toVertically: recoveredTitleLabel, toHorizontally: nil)
    }
    
    func setupData(areaData: AreaData){
        areaLabel.text = areaData.formattedTitle
        
        confirmedLabel.text = "\(areaData.cases.delimiter)"
        deathsLabel.text = "\(areaData.deaths.delimiter)"
        recoveredLabel.text = "\(areaData.recovered.delimiter)"
    }
    
}
