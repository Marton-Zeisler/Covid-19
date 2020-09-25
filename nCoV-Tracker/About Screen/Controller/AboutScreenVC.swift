//
//  AboutScreenVC.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 16..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI
import StoreKit

class AboutScreenVC: UIViewController, SFSafariViewControllerDelegate, MFMailComposeViewControllerDelegate {
    
    var mainView: AboutScreenView!
    var product: SKProduct?
    
    var overlayView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.buyCoffeeButton.addTarget(self, action: #selector(buyCoffeeTapped), for: .touchUpInside)
        mainView.removeAdsButton.addTarget(self, action: #selector(removeAdsTapped), for: .touchUpInside)
        
        if !Static.purchased{
            loadIAP()
        }else{
            mainView.hideRemoveButton(largeTitle: navigationItem.largeTitleDisplayMode == .always )
        }
    }
    
    func loadIAP(){
        IAPManager.shared.getProducts { (result) in
            if case .success(let product) = result, let priceString = IAPManager.shared.getPriceFormatted(for: product){
                self.product = product
                DispatchQueue.main.async {
                    self.mainView.setRemoveAdsPrice(priceString: priceString)
                }
            }else if case .failure(let error) = result {
                print(error.errorDescription)
            }
        }
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
        navigationItem.title = "About this app"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        let biggerThan8 = UIScreen.main.bounds.height >= 736
        let iphone5 = UIScreen.main.bounds.height == 568
        
        if biggerThan8 {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .always
        }else{
            navigationController?.navigationBar.prefersLargeTitles = false
            navigationItem.largeTitleDisplayMode = .never
            
            // iPhone 5s
            if iphone5{
                mainView.descriptionLabel.font = .systemFont(ofSize: 11, weight: .light)
            }
        }
        
        if mainView.tableViewHeightConstraint == nil{
            if iphone5 {
                mainView.tableView.rowHeight = 40
            }
            
            mainView.tableViewHeightConstraint = mainView.tableView.heightAnchor.constraint(equalToConstant: mainView.tableView.rowHeight * (Static.purchased ? 3 : 4))
            mainView.tableViewHeightConstraint?.isActive = true
        }
    }
    
    override func loadView() {
        mainView = AboutScreenView()
        self.view = mainView
    }
    
    @objc func buyCoffeeTapped(){
        if let url = URL(string: "https://www.buymeacoffee.com/martonVicky") {
            let config = SFSafariViewController.Configuration()
            let vc = SFSafariViewController(url: url, configuration: config)
            vc.preferredBarTintColor = .black
            vc.preferredControlTintColor = .white
            vc.hidesBottomBarWhenPushed = true
            vc.delegate = self
            present(vc, animated: true, completion: nil)
        }
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @objc func removeAdsTapped(){
        guard let product = product, let priceString = IAPManager.shared.getPriceFormatted(for: product) else {
            displayMessageOK(title: "Error", description: "Unable to contact App Store")
            return
        }
        
        let alertVC = UIAlertController(title: "Confirm your In-App-Purchase", message: "Do you want to Remove All Ads for \(priceString)? \n\nAds will never be displayed again after purchase.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertVC.addAction(UIAlertAction(title: "Buy", style: .default, handler: { (_) in
            self.buy(product: product)
        }))

        present(alertVC, animated: true, completion: nil)
    }
    
    func buy(product: SKProduct){
        if IAPManager.shared.canMakePayments(){
            showOverlayView()
            IAPManager.shared.buy(product: product) { (result) in
                switch result {
                case .success(_):
                    KeychainWrapper.standard.set(true, forKey: "purchase")
                    NotificationCenter.default.post(name: .removeAds, object: nil)
                    DispatchQueue.main.async {
                        self.hideOverlayView()
                        self.mainView.purchaseRestoreSuccess(purchase: true, largeTitle: self.navigationItem.largeTitleDisplayMode == .always)
                        self.mainView.tableViewHeightConstraint = self.mainView.tableView.heightAnchor.constraint(equalToConstant: self.mainView.tableView.rowHeight * 3)
                        self.mainView.tableViewHeightConstraint?.isActive = true
                        self.mainView.tableView.reloadData()
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.hideOverlayView()
                    }
                    self.displayIAPError(error: error)
                }
            }
        }else{
            displayMessageOK(title: "Error", description: "In-App-Purchases are not allowed on this device.")
        }
    }
    
    func restore(){
        showOverlayView()
        IAPManager.shared.restorePurchases { (result) in
            switch result {
            case .success(_):
                KeychainWrapper.standard.set(true, forKey: "purchase")
                NotificationCenter.default.post(name: .removeAds, object: nil)
                DispatchQueue.main.async {
                    self.hideOverlayView()
                    self.mainView.purchaseRestoreSuccess(purchase: false, largeTitle: self.navigationItem.largeTitleDisplayMode == .always)
                    self.mainView.tableViewHeightConstraint = self.mainView.tableView.heightAnchor.constraint(equalToConstant: self.mainView.tableView.rowHeight * 3)
                    self.mainView.tableViewHeightConstraint?.isActive = true
                    self.mainView.tableView.reloadData()
                }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.hideOverlayView()
                    }
                    self.displayIAPError(error: error)
            }
        }
    }
    
    func showOverlayView(){
        if let mainWindow = UIApplication.shared.keyWindow {
            overlayView = UIView(frame: mainWindow.frame)
            overlayView?.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
            overlayView?.alpha = 0.75
            
            let indicator = UIActivityIndicatorView(style: .white)
            overlayView.addSubview(indicator)
            indicator.center = overlayView.center
            indicator.startAnimating()
            mainWindow.addSubview(overlayView)
            mainWindow.bringSubviewToFront(overlayView)
        }
    }
    
    func hideOverlayView(){
        overlayView?.removeFromSuperview()
    }
    
}

extension AboutScreenVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Static.purchased ? 3 : 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = .systemFont(ofSize: UIScreen.main.bounds.height > 568 ? 20 : 16, weight: .semibold)
        
        let bg = UIView()
        bg.backgroundColor = #colorLiteral(red: 0.1725490196, green: 0.1725490196, blue: 0.1725490196, alpha: 1)
        cell.selectedBackgroundView = bg
        cell.backgroundColor = .clear
        
        if indexPath.row == 0{
            cell.textLabel?.text = "Rate this app"
        }else if indexPath.row == 1{
            cell.textLabel?.text = "About us"
        }else if indexPath.row == 2{
            cell.textLabel?.text = "Contact us"
        }else{
            cell.textLabel?.text = "Restore purchase"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0{
            SKStoreReviewController.requestReview()
        }else if indexPath.row == 1{
            let developerVC = DeveloperVC()
            developerVC.title = "About us"
            navigationController?.pushViewController(developerVC, animated: true)
        }else if indexPath.row == 2{
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients(["covid19app@gmail.com"])
                present(mail, animated: true)
            } else {
                let alertVC = UIAlertController(title: "Unable to send email", message: "You don't have an email account setup on your device.", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertVC, animated: true, completion: nil)
            }
        }else{
            restore()
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}
