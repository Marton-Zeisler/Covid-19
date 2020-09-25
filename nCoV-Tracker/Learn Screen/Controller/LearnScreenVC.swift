//
//  InfoScreenVC.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 12..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import UIKit
import GoogleMobileAds

class LearnScreenVC: UIViewController, UITableViewDelegate, UITableViewDataSource, GADBannerViewDelegate {

    let upperView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
        view.setShadows(shadowColor: .black, shadowOpacity: 0.5, shadowOffset: CGPoint(x: 0, y: 2), shadowBlur: 7)
        return view
    }()
    
    let sourceLabel: UILabel = {
        let label = UILabel()
        label.text = ""//"Source: World Health Organization"
        label.textColor = .white
        label.font = .systemFont(ofSize: 8, weight: .light)
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 300
        tableView.register(LearnCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        tableView.delaysContentTouches = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        tableView.indicatorStyle = .white
        return tableView
    }()
    
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1)

        view.addSubview(UIView(frame: .zero))
        view.addSubview(tableView)
        view.addSubview(upperView)
        view.addSubview(sourceLabel)
        sourceLabel.setAnchors(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: nil, bottom: nil, topConstant: 10, leadingConstant: 17, trailingConstant: nil, bottomConstant: nil)
        upperView.setAnchors(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: sourceLabel.bottomAnchor, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: -10)
        
        tableView.setAnchors(top: upperView.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0)
        tableView.delegate = self
        tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(removeAdsPurchased), name: .removeAds, object: nil)
    }
    
    @objc func removeAdsPurchased(){
        bannerView?.removeFromSuperview()
        tableView.contentInset.bottom -= 50
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.title = "Information"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !Static.purchased{
            loadAd()
        }
    }
    
    func loadAd(){
        if bannerView != nil { return }
        bannerView = GADBannerView(adSize: GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(view.frame.width))
        bannerView.backgroundColor = .clear
        bannerView.rootViewController = self
        bannerView.adUnitID = Static.bannerID
        bannerView.isAutoloadEnabled = true
        bannerView.load(GADRequest())
        bannerView.delegate = self
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        if bannerView.superview == nil{
            view.addSubview(bannerView)
            bannerView.setAnchors(top: nil, leading: nil, trailing: nil, bottom: view.bottomAnchor, topConstant: nil, leadingConstant: nil, trailingConstant: nil, bottomConstant: 0)
            bannerView.center(toVertically: nil, toHorizontally: view)
            tableView.contentInset.bottom += 50
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LearnCell else { return UITableViewCell() }
        if indexPath.section == 0{
            cell.titleLabel.text = "About the coronavirus"
            cell.detailLabel.text = LearnData.aboutArticle
            cell.bannerImageView.image = #imageLiteral(resourceName: "learnCell0")
        }else if indexPath.section == 1{
            cell.titleLabel.text = "How to protect yourself"
            cell.bannerImageView.image = #imageLiteral(resourceName: "learnCell1")
            cell.detailLabel.text = LearnData.protectCellDescription
        }else if indexPath.section == 2{
            cell.titleLabel.text = "Q&A on coronavirus"
            cell.bannerImageView.image = #imageLiteral(resourceName: "learnCell2")
            cell.detailLabel.text = LearnData.questionsCellDescription
        }else{
            cell.titleLabel.text = "Myth busters"
            cell.bannerImageView.image = #imageLiteral(resourceName: "learnCell3")
            cell.detailLabel.text = LearnData.mythCellDescription
        }
        
        cell.readMoreButton.addTarget(self, action: #selector(readMoreTapped(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func readMoreTapped(_ sender: UIButton){
        let position = sender.convert(CGPoint.zero, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: position) {
            performCellAction(section: indexPath.section)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section != 0 {
            return UIView()
        }else{
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performCellAction(section: indexPath.section)
    }
    
    func performCellAction(section: Int){
        if section == 0{
            let aboutVC = AboutVirusVC()
            aboutVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(aboutVC, animated: true)
        }else if section == 1{
            let protectVC = ArticleVC()
            protectVC.title = "Protect yourself"
            protectVC.tableData = LearnData.protectData
            protectVC.bannerImage = #imageLiteral(resourceName: "learnCell1")
            protectVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(protectVC, animated: true)
        }else if section == 2{
            let protectVC = ArticleVC()
            protectVC.title = "Q&A"
            protectVC.tableData = LearnData.questionsData
            protectVC.bannerImage = #imageLiteral(resourceName: "learnCell2")
            protectVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(protectVC, animated: true)
        }else{
            let protectVC = ArticleVC()
            protectVC.title = "Myth busters"
            protectVC.tableData = LearnData.mythData
            protectVC.bannerImage = #imageLiteral(resourceName: "learnCell3")
            protectVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(protectVC, animated: true)
        }
    }

}
