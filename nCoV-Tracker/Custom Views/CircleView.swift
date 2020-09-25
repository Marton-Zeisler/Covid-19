//
//  CircleView.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 12..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import UIKit

class CircleView: BaseView {
    
    var outsideCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.7529411765, green: 0.2392156863, blue: 0.2980392157, alpha: 0.5)
        return view
    }()
    
    var middleCircleView: UIView = {
        let view = UIView()
        view.layer.opacity = 0.46
        view.backgroundColor = #colorLiteral(red: 0.6862745098, green: 0.1254901961, blue: 0.1882352941, alpha: 1)
        return view
    }()
    
    var insideCircleView: UIView = {
        let view = UIView()
        view.layer.opacity = 0.46
        view.backgroundColor = #colorLiteral(red: 0.6862745098, green: 0.1254901961, blue: 0.1882352941, alpha: 1)
        return view
    }()
    
    
    override func setupViews() {
        backgroundColor = .clear
        addSubview(insideCircleView)
        insideCircleView.fillSuperView()
        
        addSubview(middleCircleView)
        middleCircleView.center(toVertically: insideCircleView, toHorizontally: insideCircleView)
        
        addSubview(outsideCircleView)
        outsideCircleView.center(toVertically: middleCircleView, toHorizontally: middleCircleView)
    }
    
    override func layoutSubviews() {
        insideCircleView.layer.cornerRadius = frame.height / 2
        
        middleCircleView.setAnchorSize(width: frame.height*0.867021277, height: frame.height*0.867021277)
        middleCircleView.layoutIfNeeded()
        middleCircleView.layer.cornerRadius = middleCircleView.frame.height / 2
        
        outsideCircleView.setAnchorSize(width: frame.height*0.739361702, height: frame.height*0.739361702)
        outsideCircleView.layoutIfNeeded()
        outsideCircleView.layer.cornerRadius = outsideCircleView.frame.height / 2
    }
    
}
