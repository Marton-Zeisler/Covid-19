//
//  AboutVirusVC.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 17..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AboutVirusVC: UIViewController, GADBannerViewDelegate {
    
    let bannerImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "learnCell0"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delaysContentTouches = false
        scrollView.indicatorStyle = .white
        return scrollView
    }()
    
    let viewInScroll: UIView = {
        let view = UIView()
        return view
    }()
    
    let sourceLabel: UILabel = {
        let label = UILabel()
        label.text = ""//"Source: World Health Organization"
        label.textColor = .white
        label.font = .systemFont(ofSize: 8, weight: .light)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.numberOfLines = 0
        label.text = LearnData.aboutArticle
        //label.sizeToFit()
        return label
    }()
    
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
        extendedLayoutIncludesOpaqueBars = true
        
        view.addSubview(scrollView)
        scrollView.contentOffset = CGPoint(x: 0, y: view.safeAreaInsets.top)
        scrollView.fillSuperView()
        
        scrollView.addSubview(viewInScroll)
        viewInScroll.fillSuperView()
        viewInScroll.setAnchorSize(to: view, widthMultiplier: 1, heightMultiplier: nil)
        
        viewInScroll.addSubview(sourceLabel)
        sourceLabel.setAnchors(top: viewInScroll.topAnchor, leading: viewInScroll.leadingAnchor, trailing: nil, bottom: nil, topConstant: 0, leadingConstant: 17, trailingConstant: nil, bottomConstant: 0)
        
        viewInScroll.addSubview(bannerImageView)
        bannerImageView.setAnchors(top: sourceLabel.bottomAnchor, leading: viewInScroll.leadingAnchor, trailing: viewInScroll.trailingAnchor, bottom: nil, topConstant: 10, leadingConstant: 0, trailingConstant: 0, bottomConstant: nil)
        bannerImageView.setAnchorSize(width: nil, height: 220)
        
        viewInScroll.addSubview(descriptionLabel)
        descriptionLabel.setAnchors(top: bannerImageView.bottomAnchor, leading: viewInScroll.leadingAnchor, trailing: viewInScroll.trailingAnchor, bottom: viewInScroll.bottomAnchor, topConstant: 30, leadingConstant: 17, trailingConstant: 17, bottomConstant: 50)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "About the virus"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
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
            bannerView.setAnchors(top: nil, leading: nil, trailing: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, topConstant: nil, leadingConstant: nil, trailingConstant: nil, bottomConstant: 0)
            bannerView.center(toVertically: nil, toHorizontally: view)
            scrollView.contentInset.bottom += 60 + view.safeAreaInsets.bottom
            
            let bg = UIView()
            bg.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
            view.addSubview(bg)
            bg.setAnchors(top: bannerView.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0)
        }
    }

}
