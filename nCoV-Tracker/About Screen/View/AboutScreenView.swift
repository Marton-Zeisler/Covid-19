//
//  AboutScreenView.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 16..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import UIKit

class AboutScreenView: BaseView {

    let upperView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2078431373, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        return view
    }()
        
    let removeAdsButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.7529411765, green: 0.2392156863, blue: 0.2980392157, alpha: 1)
        button.layer.cornerRadius = 8
        button.setShadows(shadowColor: #colorLiteral(red: 0.2980392157, green: 0.2980392157, blue: 0.2980392157, alpha: 1), shadowOpacity: 0.5, shadowOffset: CGPoint(x: 0, y: 2), shadowBlur: 10)
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        button.titleLabel?.numberOfLines = 0
        return button
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "CoroMap is using accurate and regualarly updated data from reliable sources. For more information regarding the virus please check your local authority. In case of emergency, please call your local emergency hotlines."
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.backgroundColor = .clear
        label.numberOfLines = 0
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 50
        tableView.separatorColor = #colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        tableView.indicatorStyle = .white
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    let bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "Developed in Cardiff • Designed in California"
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let findLabel: UILabel = {
        let label = UILabel()
        label.text = "Find this app useful?"
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    let buyCoffeeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "buyCoffee").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    var upperViewBottomConstraint: NSLayoutConstraint?
    var tableViewHeightConstraint: NSLayoutConstraint?
    
    override func setupViews() {
        backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
        
        addSubview(upperView)
        
        addSubview(removeAdsButton)
        removeAdsButton.setAnchors(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: nil, topConstant: 20, leadingConstant: 20, trailingConstant: 20, bottomConstant: nil)
        removeAdsButton.setContentHuggingPriority(.required, for: .vertical)
        setRemoveAdsPrice(priceString: "")
        
        upperView.setAnchors(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: nil)
        upperViewBottomConstraint = upperView.bottomAnchor.constraint(equalTo: removeAdsButton.bottomAnchor, constant: 20)
        upperViewBottomConstraint?.isActive = true
        
        addSubview(descriptionLabel)
        descriptionLabel.setAnchors(top: upperView.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: nil, topConstant: 20, leadingConstant: 20, trailingConstant: 20, bottomConstant: nil)
        
        addSubview(bottomLabel)
        bottomLabel.setAnchors(top: nil, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, topConstant: nil, leadingConstant: 0, trailingConstant: 0, bottomConstant: 12)
        bottomLabel.setAnchorSize(width: nil, height: 20)
        
        addSubview(tableView)
        tableView.setAnchors(top: descriptionLabel.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: nil, topConstant: 20, leadingConstant: 0, trailingConstant: 0, bottomConstant: nil)
        
        addSubview(findLabel)
        findLabel.setAnchors(top: tableView.bottomAnchor, leading: nil, trailing: nil, bottom: nil, topConstant: 20, leadingConstant: nil, trailingConstant: nil, bottomConstant: nil)
        findLabel.center(toVertically: nil, toHorizontally: self)
        
        addSubview(buyCoffeeButton)
        buyCoffeeButton.setAnchors(top: findLabel.bottomAnchor, leading: nil, trailing: nil, bottom: nil, topConstant: 7, leadingConstant: nil, trailingConstant: nil, bottomConstant: nil)
        buyCoffeeButton.center(toVertically: nil, toHorizontally: self)
    }
    
    func setRemoveAdsPrice(priceString: String){
        let titleString = priceString.isEmpty ? "Remove ads" : "Remove ads for \(priceString)"
        let attributedString = NSMutableAttributedString(string: titleString, attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 20, weight: .semibold)])
        attributedString.append(NSAttributedString(string: "\n"))
        attributedString.append(NSAttributedString(string: "One time purchase", attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 15, weight: .light)]))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 4
        attributedString.addAttributes([.paragraphStyle: paragraphStyle], range: NSRange(location: 0, length: attributedString.mutableString.length))
        
        UIView.performWithoutAnimation {
            removeAdsButton.setAttributedTitle(attributedString, for: .normal)
            removeAdsButton.layoutIfNeeded()
        }
    }
    
    func hideRemoveButton(largeTitle: Bool){
        removeAdsButton.removeFromSuperview()
        upperViewBottomConstraint?.isActive = false
        upperViewBottomConstraint = upperView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: largeTitle ? 10 : 0)
        upperViewBottomConstraint?.isActive = true
    }
    
    func purchaseRestoreSuccess(purchase: Bool, largeTitle: Bool){
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.6549019608, blue: 0.3019607843, alpha: 1)
        view.layer.cornerRadius = 8
        view.alpha = 0
        
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.text = purchase ? "Purchase successful" : "Purchase restored"
        
        addSubview(view)
        view.setAnchors(top: nil, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, topConstant: nil, leadingConstant: 20, trailingConstant: 20, bottomConstant: 12)
        view.setAnchorSize(width: nil, height: 50)
        view.addSubview(label)
        label.center(toVertically: view, toHorizontally: view)
        
        bottomLabel.alpha = 0
        
        if buyCoffeeButton.frame.maxY >= (frame.maxY - 82){
            buyCoffeeButton.alpha = 0
            bottomLabel.alpha = 0
        }
                
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            view.alpha = 1
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveLinear, animations: {
                view.alpha = 0
            }) { (_) in
                view.removeFromSuperview()
                self.bottomLabel.alpha = 1
                self.buyCoffeeButton.alpha = 1
                self.findLabel.alpha = 1
                self.hideRemoveButton(largeTitle: largeTitle)
            }
        }
    }

}
