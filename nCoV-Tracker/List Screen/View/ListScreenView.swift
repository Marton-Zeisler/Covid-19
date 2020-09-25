//
//  ListScreenView.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 12..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import UIKit

class ListScreenView: BaseView {
    
    let upperView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2078431373, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        view.setShadows(shadowColor: .black, shadowOpacity: 0.5, shadowOffset: CGPoint(x: 0, y: 2), shadowBlur: 7)
        return view
    }()
    
    let casesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CASES", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    let deathsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("DEATHS", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .light)
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    let recoveredButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("RECOVERED", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .light)
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [casesButton, deathsButton, recoveredButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        searchBar.setImage(#imageLiteral(resourceName: "searchIcon"), for: .search, state: .normal)
        searchBar.setPositionAdjustment(UIOffset(horizontal: 3, vertical: 0), for: .search)
        searchBar.searchTextPositionAdjustment = UIOffset(horizontal: 3, vertical: 0)
        return searchBar
    }()

    let worldWideView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.7529411765, green: 0.2392156863, blue: 0.2980392157, alpha: 1)
        view.layer.cornerRadius = 8
        view.setShadows(shadowColor: #colorLiteral(red: 0.2980392157, green: 0.2980392157, blue: 0.2980392157, alpha: 1), shadowOpacity: 0.5, shadowOffset: CGPoint(x: 0, y: 2), shadowBlur: 10)
        return view
    }()
    
    let worldNumberLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(CountryHeaderView.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.register(AreaCell.self, forCellReuseIdentifier: "cell")
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.sectionHeaderHeight = 64
        tableView.sectionFooterHeight = 0
        tableView.indicatorStyle = .white
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        return tableView
    }()
    
    let updateView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
        view.setShadows(shadowColor: .black, shadowOpacity: 0.3, shadowOffset: CGPoint(x: 0, y: -2), shadowBlur: 4)
        return view
    }()
    
    let updateLabel: UILabel = {
        let label = UILabel()
        label.text = "Last Update: "
        label.textColor = .white
        label.font = .systemFont(ofSize: 8, weight: .light)
        label.textAlignment = .center
        return label
    }()
    
    var underlineCenterConstraint: NSLayoutConstraint?
    
    override func setupViews() {
        backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
        
        addSubview(tableView)
        
        addSubview(upperView)
        upperView.setAnchors(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: nil)
        
        upperView.addSubview(underlineView)
        
        upperView.addSubview(buttonsStackView)
        buttonsStackView.setAnchors(top: upperView.safeAreaLayoutGuide.topAnchor, leading: upperView.leadingAnchor, trailing: upperView.trailingAnchor, bottom: nil, topConstant: 20, leadingConstant: 0, trailingConstant: 0, bottomConstant: nil)
        casesButton.setAnchorSize(width: nil, height: 40)
        
        underlineView.setAnchorSize(width: nil, height: 3)
        underlineView.setAnchorSize(to: casesButton, widthMultiplier: 0.65, heightMultiplier: nil)
        underlineView.setAnchors(top: casesButton.bottomAnchor, leading: nil, trailing: nil, bottom: nil, topConstant: 0, leadingConstant: nil, trailingConstant: nil, bottomConstant: nil)
        underlineCenterConstraint = underlineView.centerXAnchor.constraint(equalTo: casesButton.centerXAnchor)
        underlineCenterConstraint?.isActive = true
        
        upperView.addSubview(searchBar) // search text field is 8 points away from its superview search bar view
        searchBar.setAnchors(top: buttonsStackView.bottomAnchor, leading: upperView.leadingAnchor, trailing: upperView.trailingAnchor, bottom: nil, topConstant: 20, leadingConstant: 12, trailingConstant: 12, bottomConstant: nil)
        
        upperView.addSubview(worldWideView)
        worldWideView.setAnchors(top: searchBar.bottomAnchor, leading: upperView.leadingAnchor, trailing: upperView.trailingAnchor, bottom: upperView.bottomAnchor, topConstant: 10, leadingConstant: 18, trailingConstant: 18, bottomConstant: 16)
        
        worldWideView.addSubview(worldNumberLabel)
        worldNumberLabel.setAnchors(top: worldWideView.topAnchor, leading: worldWideView.leadingAnchor, trailing: worldWideView.trailingAnchor, bottom: worldWideView.bottomAnchor, topConstant: 10, leadingConstant: 0, trailingConstant: 0, bottomConstant: 10)
        
        addSubview(updateView)
        updateView.setAnchors(top: nil, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, topConstant: nil, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0)
        updateView.setAnchorSize(width: nil, height: 25)
        
        updateView.addSubview(updateLabel)
        updateLabel.center(toVertically: updateView, toHorizontally: updateView)
        
        tableView.setAnchors(top: upperView.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: updateView.topAnchor, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0)
    }
    
    func updateMenu(worldStatsType: WorldStatsType){
        if worldStatsType == .cases{
            casesButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
            deathsButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .light)
            recoveredButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .light)
            
            underlineCenterConstraint?.isActive = false
            underlineCenterConstraint = underlineView.centerXAnchor.constraint(equalTo: casesButton.centerXAnchor)
            underlineCenterConstraint?.isActive = true
            
            worldWideView.backgroundColor = worldStatsType.getColor()
        }else if worldStatsType == .deaths{
            deathsButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
            casesButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .light)
            recoveredButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .light)
            
            underlineCenterConstraint?.isActive = false
            underlineCenterConstraint = underlineView.centerXAnchor.constraint(equalTo: deathsButton.centerXAnchor)
            underlineCenterConstraint?.isActive = true
            
            worldWideView.backgroundColor = worldStatsType.getColor()
        }else{
            recoveredButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
            casesButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .light)
            deathsButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .light)
            
            underlineCenterConstraint?.isActive = false
            underlineCenterConstraint = underlineView.centerXAnchor.constraint(equalTo: recoveredButton.centerXAnchor)
            underlineCenterConstraint?.isActive = true
            
            worldWideView.backgroundColor = worldStatsType.getColor()
        }
    }
    
    func getAttributedStringForWorldNumber(worldStatsType: WorldStatsType) -> NSAttributedString {
        var number = 0
        if worldStatsType == .cases{
            number = ListData.shared.worldWideCases
        }else if worldStatsType == .deaths {
            number = ListData.shared.worldWideDeaths
        }else{
            number = ListData.shared.worldWideRecovered
        }
        
        let attributedString = NSMutableAttributedString(string: worldStatsType.rawValue, attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 15, weight: .light)])
        attributedString.append(NSAttributedString(string: "\n"))
        attributedString.append(NSAttributedString(string: number.delimiter, attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 27, weight: .semibold)]))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        paragraphStyle.alignment = .center
        attributedString.addAttributes([.paragraphStyle: paragraphStyle], range: NSRange(location: 0, length: attributedString.mutableString.length))
        return attributedString
    }

    
}

enum WorldStatsType: String{
    case cases = "Worldwide confirmed cases"
    case deaths = "Worldwide deaths"
    case recovered = "Worldwide recovered"
    
    func getColor() -> UIColor{
        switch self {
        case .cases:
            return #colorLiteral(red: 0.7529411765, green: 0.2392156863, blue: 0.2980392157, alpha: 1)
        case .deaths:
            return #colorLiteral(red: 0.5176470588, green: 0.5176470588, blue: 0.5176470588, alpha: 1)
        case .recovered:
            return #colorLiteral(red: 0.2549019608, green: 0.7215686275, blue: 0.6980392157, alpha: 1)
        }
    }
}
