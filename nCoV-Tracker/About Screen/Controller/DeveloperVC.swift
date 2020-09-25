//
//  DeveloperVC.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 16..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import UIKit
import SafariServices

class DeveloperVC: UIViewController, UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate {

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Our mission is to help people to be aware of this outbreak by providing the latest statistics of cases around the world. "
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.backgroundColor = .clear
        label.numberOfLines = 0
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 55
        tableView.separatorColor = #colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        tableView.indicatorStyle = .white
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        tableView.register(DeveloperCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
        
        view.addSubview(descriptionLabel)
        descriptionLabel.setAnchors(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, topConstant: 20, leadingConstant: 20, trailingConstant: 20, bottomConstant: 0)
        
        view.addSubview(tableView)
        tableView.setAnchors(top: descriptionLabel.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, topConstant: 30, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? DeveloperCell else { return UITableViewCell() }
        
        if indexPath.row == 0{
            cell.textLabel?.text = "Developer"
            cell.personLabel.text = "Marton Zeisler"
        }else{
            cell.textLabel?.text = "Designer"
            cell.personLabel.text = "Uyen Vicky Vo"
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.row == 0{
            openURL(string: "https://www.martonz.com")
        }else{
            openURL(string: "https://vickyvo.me")
        }
    }
    
    func openURL(string: String){
        if let url = URL(string: string) {
            let config = SFSafariViewController.Configuration()
            let vc = SFSafariViewController(url: url, configuration: config)
            vc.preferredBarTintColor = .black
            vc.preferredControlTintColor = .white
            vc.hidesBottomBarWhenPushed = true
            vc.delegate = self
            present(vc, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }

}
