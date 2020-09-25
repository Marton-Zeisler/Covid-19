//
//  AreaCell.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 13..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import UIKit

class AreaCell: BaseTableCell {
    
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2156862745, green: 0.2156862745, blue: 0.2156862745, alpha: 1)
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    let areaLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    let counterLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.8784313725, green: 0.4039215686, blue: 0.4705882353, alpha: 1)
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .right
        return label
    }()
    
    var areaLabelTopConstraint: NSLayoutConstraint!
    var areaLabelBottomConstraint: NSLayoutConstraint!
    var areaLabelCenterConstraint: NSLayoutConstraint!
    
    var counterLabelTopConstraint: NSLayoutConstraint!
    var counterLabelBottomConstraint: NSLayoutConstraint!
    var counterLabelCenterConstraint: NSLayoutConstraint!
    
    override func setupViews() {
        backgroundColor = .clear
        addSubview(mainView)
        mainView.setAnchors(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, topConstant: 0, leadingConstant: 18, trailingConstant: 18, bottomConstant: 0)
        
        mainView.addSubview(counterLabel)
        counterLabel.setAnchors(top: nil, leading: nil, trailing: mainView.trailingAnchor, bottom: nil, topConstant: nil, leadingConstant: nil, trailingConstant: 20, bottomConstant: nil)
        counterLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        mainView.addSubview(areaLabel)
        areaLabel.setAnchors(top: nil, leading: mainView.leadingAnchor, trailing: nil, bottom: nil, topConstant: nil, leadingConstant: 20, trailingConstant: nil, bottomConstant: nil)
        areaLabel.trailingAnchor.constraint(lessThanOrEqualTo: counterLabel.leadingAnchor, constant: -30).isActive = true
        
        // top cell
        areaLabelBottomConstraint = areaLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -5)
        counterLabelBottomConstraint = counterLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -5)
        
        // center cell
        areaLabelCenterConstraint = areaLabel.centerYAnchor.constraint(equalTo: mainView.centerYAnchor)
        counterLabelCenterConstraint = counterLabel.centerYAnchor.constraint(equalTo: mainView.centerYAnchor)
        
        // bottom cell
        areaLabelTopConstraint = areaLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 5)
        counterLabelTopConstraint = counterLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 5)
    }
    
    func topCell(){
        NSLayoutConstraint.deactivate([areaLabelTopConstraint, areaLabelCenterConstraint, counterLabelTopConstraint, counterLabelCenterConstraint])
        NSLayoutConstraint.activate([areaLabelBottomConstraint, counterLabelBottomConstraint])
    }
    
    func middleCell(){
        NSLayoutConstraint.deactivate([areaLabelTopConstraint, areaLabelBottomConstraint, counterLabelTopConstraint, counterLabelBottomConstraint])
        NSLayoutConstraint.activate([areaLabelCenterConstraint, counterLabelCenterConstraint])
    }
    
    func bottomCell(){
        NSLayoutConstraint.deactivate([areaLabelBottomConstraint, areaLabelCenterConstraint, counterLabelBottomConstraint, counterLabelCenterConstraint])
        NSLayoutConstraint.activate([areaLabelTopConstraint, counterLabelTopConstraint])
    }
    
    func setupData(area: Area, worldStatsType: WorldStatsType){
        areaLabel.text = area.name
        
        if worldStatsType == .cases{
            counterLabel.text = area.cases.delimiter
        }else if worldStatsType == .deaths{
            counterLabel.text = area.deaths.delimiter
        }else{
            counterLabel.text = area.recovered.delimiter
        }
        
        setColor(worldStatsType: worldStatsType)
    }
    
    func setColor(worldStatsType: WorldStatsType){
        counterLabel.textColor = worldStatsType.getColor()
    }
    
    
}
