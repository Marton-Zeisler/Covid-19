//
//  LearnCell.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 16..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import UIKit

class LearnCell: BaseTableCell {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "About the coronavirus"
        label.textColor = .white
        return label
    }()
    
    let bannerImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "learnCell0"))
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.text = "Coronaviruses (CoV) are a large family of viruses that cause illness ranging from the common cold to more severe diseases such as Middle East Respiratory Syndrome (MERS-CoV) and Severe Acute Respiratory Syndrome (SARS-CoV). A novel coronavirus (nCoV) is a new strain that has not been previously identified in humans."
        label.numberOfLines = 0
        return label
    }()
    
    let readMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("READ MORE", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.8784313725, green: 0.4039215686, blue: 0.4705882353, alpha: 1), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.setImage(#imageLiteral(resourceName: "rightRedArrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentHorizontalAlignment = .left
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.contentVerticalAlignment = .center
        return button
    }()
    
    override func setupViews() {
        let bg = UIView()
        bg.backgroundColor = #colorLiteral(red: 0.1725490196, green: 0.1725490196, blue: 0.1725490196, alpha: 1)
        selectedBackgroundView = bg
        backgroundColor = #colorLiteral(red: 0.2078431373, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        setShadows(shadowColor: .black, shadowOpacity: 0.2, shadowOffset: CGPoint(x: 0, y: 2), shadowBlur: 2)
        
        addSubview(readMoreButton)
        readMoreButton.setAnchors(top: nil, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, topConstant: nil, leadingConstant: 20, trailingConstant: nil, bottomConstant: 0)
        readMoreButton.setContentHuggingPriority(.required, for: .vertical)
        readMoreButton.setAnchorSize(width: 150, height: 60)
        
        addSubview(titleLabel)
        titleLabel.setAnchors(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: nil, topConstant: 25, leadingConstant: 20, trailingConstant: 20, bottomConstant: nil)
        
        addSubview(bannerImageView)
        bannerImageView.setAnchors(top: titleLabel.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: nil, topConstant: 20, leadingConstant: 20, trailingConstant: 20, bottomConstant: nil)
        bannerImageView.setAnchorSize(width: nil, height: 87)
        
        addSubview(detailLabel)
        detailLabel.setAnchors(top: bannerImageView.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: readMoreButton.topAnchor, topConstant: 10, leadingConstant: 20, trailingConstant: 20, bottomConstant: 0)
    }

}
