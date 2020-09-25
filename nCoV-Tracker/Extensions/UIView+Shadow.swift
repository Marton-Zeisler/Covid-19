//
//  UIView+Shadow.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 12..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import UIKit

extension UIView{
    func setShadows(shadowColor: UIColor, shadowOpacity: Float, shadowOffset: CGPoint, shadowBlur: CGFloat, shadowSpread: CGFloat = 0){
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = CGSize(width: shadowOffset.x, height: shadowOffset.y)
        layer.shadowRadius = shadowBlur / 2.0
        
        if shadowSpread == 0 {
            layer.shadowPath = nil
        } else {
            let dx = -shadowSpread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
