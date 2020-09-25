//
//  ListSearchResultsView.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 16..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import UIKit

class ListSearchResultsView: BaseView {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.rowHeight = 123.5
        tableView.register(SearchCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        tableView.separatorColor = #colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        tableView.keyboardDismissMode = .interactive
        tableView.indicatorStyle = .white
        tableView.allowsSelection = false 
        return tableView
    }()
    
    let noResultsLabel: UILabel = {
        let label = UILabel()
        label.text = "No Results"
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.isHidden = true
        return label
    }()
    
    override func setupViews(){
        backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
        
        addSubview(tableView)
        tableView.setAnchors(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0)
        
        addSubview(noResultsLabel)
        noResultsLabel.setAnchors(top: safeAreaLayoutGuide.topAnchor, leading: nil, trailing: nil, bottom: nil, topConstant: 20, leadingConstant: nil, trailingConstant: nil, bottomConstant: nil)
        noResultsLabel.center(toVertically: nil, toHorizontally: self)
    }

}
