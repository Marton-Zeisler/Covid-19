//
//  ProtectCell.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 17..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import UIKit

class ProtectCell: BaseTableCell {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Wash your hands frequently"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Wash your hands frequently with soap and water or use an alcohol-based hand rub if your hands are not visibly dirty."
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    override func setupViews() {
        backgroundColor = .clear
        
        addSubview(titleLabel)
        titleLabel.setAnchors(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: nil, topConstant: 15, leadingConstant: 20, trailingConstant: 20, bottomConstant: 0)
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        
        addSubview(descriptionLabel)
        descriptionLabel.setAnchors(top: titleLabel.bottomAnchor, leading: titleLabel.leadingAnchor, trailing: titleLabel.trailingAnchor, bottom: bottomAnchor, topConstant: 5, leadingConstant: 0, trailingConstant: 0, bottomConstant: 10)
    }
    
    func setupData(data: ArticleData){
        titleLabel.text = data.title
        descriptionLabel.text = data.description
    }
    
}
