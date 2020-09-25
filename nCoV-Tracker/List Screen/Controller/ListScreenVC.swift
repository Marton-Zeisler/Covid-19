//
//  ListScreenVC.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 12..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ListScreenVC: UIViewController {

    var mainView: ListScreenView!
    var worldStatsType: WorldStatsType = .cases
    
    var casesContentOffset: CGPoint?
    var deathsContentOffset: CGPoint?
    var recoveredContentOffset: CGPoint?
    
    var searchController: UISearchController!
    var searchResultsVC: ListSearchResultsVC!
    
    var updateDateString: String?
    
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.casesButton.addTarget(self, action: #selector(casesTapped), for: .touchUpInside)
        mainView.deathsButton.addTarget(self, action: #selector(deathsTapped), for: .touchUpInside)
        mainView.recoveredButton.addTarget(self, action: #selector(recoveredTapped), for: .touchUpInside)

        loadDataUI()
        
        setupSearchBar()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        if !Static.purchased {
            interstitial = createAndLoadInterstitial()
        }
    }
    
    func loadDataUI(){
        // Only when view has been loaded
        if mainView == nil { return }
        ListData.shared.sortData()
        mainView.tableView.reloadData()
        mainView.worldNumberLabel.attributedText = mainView.getAttributedStringForWorldNumber(worldStatsType: worldStatsType)
        mainView.updateLabel.text = ListData.shared.updateDateString ?? "Last Updated: "
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: Static.intersitialID)
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func loadView() {
        mainView = ListScreenView()
        self.view = mainView
    }
    
    func setupSearchBar(){
        searchResultsVC = ListSearchResultsVC()
        searchController = UISearchController(searchResultsController: searchResultsVC)
        navigationItem.titleView = searchController.searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchResultsUpdater = searchResultsVC
        searchController.searchBar.delegate = self
        if #available(iOS 13.0, *) {
            searchController.automaticallyShowsCancelButton = true
        }
        searchController.searchBar.placeholder = "Search"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.barStyle = .blackTranslucent
        searchController.searchBar.autocapitalizationType = .words
        searchController.searchBar.autocorrectionType = .yes
        searchController.searchBar.keyboardAppearance = .dark
        definesPresentationContext = true
        mainView.searchBar.delegate = self
    }

    @objc func casesTapped(){
        loadAdIfNeeded()
        
        if worldStatsType == .cases { return }
        saveContentOffset()
        
        worldStatsType = .cases
        mainView.updateMenu(worldStatsType: worldStatsType)
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.mainView.tableView.setContentOffset(self.casesContentOffset ?? .zero, animated: false)
        }
        
        mainView.tableView.reloadData()
        mainView.tableView.layoutIfNeeded()
        CATransaction.commit()
    }
    
    @objc func deathsTapped(){
        loadAdIfNeeded()
        
        if worldStatsType == .deaths { return }
        saveContentOffset()
        
        worldStatsType = .deaths
        mainView.updateMenu(worldStatsType: worldStatsType)
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.mainView.tableView.setContentOffset(self.deathsContentOffset ?? .zero, animated: false)
        }
        
        mainView.tableView.reloadData()
        mainView.tableView.layoutIfNeeded()
        CATransaction.commit()
    }
    
    @objc func recoveredTapped(){
        loadAdIfNeeded()
        
        if worldStatsType == .recovered { return }
        saveContentOffset()
        
        worldStatsType = .recovered
        mainView.updateMenu(worldStatsType: worldStatsType)
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.mainView.tableView.setContentOffset(self.recoveredContentOffset ?? .zero, animated: false)
        }
        
        mainView.tableView.reloadData()
        mainView.tableView.layoutIfNeeded()
        CATransaction.commit()
    }
    
    func loadAdIfNeeded(){
        if Static.purchased { return }
        
        if Static.timeToShowAd {
            interstitial.present(fromRootViewController: self)
        }
        
        Static.userInteractionsCounter += 1
    }
    
    func saveContentOffset(){
        if worldStatsType == .cases{
            casesContentOffset = mainView.tableView.contentOffset
        }else if worldStatsType == .deaths{
            deathsContentOffset = mainView.tableView.contentOffset
        }else{
            recoveredContentOffset = mainView.tableView.contentOffset
        }
    }
    
    @objc func keyboardUp(notification: Notification) {
        if searchResultsVC.keyboardHeight != nil { return }
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        searchResultsVC.keyboardHeight = keyboardViewEndFrame.height
    }
}

extension ListScreenVC: UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if searchBar == searchController.searchBar{
            searchBar.endEditing(true)
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        if searchBar == mainView.searchBar{
            navigationController?.setNavigationBarHidden(false, animated: true)
            searchController.searchBar.becomeFirstResponder()
            return false
        }
        
        return true
    }
    
    
}

extension ListScreenVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return ListData.shared.getCountries(for: worldStatsType).count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = ListData.shared.getCountries(for: worldStatsType)[section].tableData.count
        
        return count == 0 ? 1 : count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataCount = ListData.shared.getCountries(for: worldStatsType)[indexPath.section].tableData.count
        
        if dataCount == 0 { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AreaCell else {
            return UITableViewCell()
        }
        
        cell.setupData(area: ListData.shared.getCountries(for: worldStatsType)[indexPath.section].areas[indexPath.row], worldStatsType: worldStatsType)
        
        if indexPath.row == dataCount - 1{
            // Last cell, need rounded corners for bottom
            cell.mainView.layer.cornerRadius = 8
        }else{
            // No need rounded corners
            cell.mainView.layer.cornerRadius = 0
        }

        // Bottom cell of table
        if (indexPath.row - 1 >= 0 && indexPath.row == dataCount - 1){
            cell.bottomCell()
        }

        // Middle cell of table
        if (indexPath.row - 1 >= 0 && indexPath.row + 1 < dataCount) || dataCount == 1{
            cell.middleCell()
        }

        // Top cell of table
        if (indexPath.row == 0 && indexPath.row + 1 < dataCount){
            cell.topCell()
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CountryHeaderView{
            header.sectionIndex = section
            if header.gestureRecognizers == nil{
                header.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(headerTapped(_:))))
            }
    
            header.setupData(country: ListData.shared.getCountries(for: worldStatsType)[section], worldStatsType: worldStatsType)
            
            if ListData.shared.getCountries(for: worldStatsType)[section].tableData.isEmpty{
                header.showClosed()
            }else{
                header.showOpen()
            }
            
            return header
        }else{
            return nil
        }
    }
    
    @objc func headerTapped(_ sender: UITapGestureRecognizer){
        if let headerView = sender.view as? CountryHeaderView, let sectionIndex = headerView.sectionIndex {
            // No cities found for that country, don't do anything if header tapped
            if ListData.shared.getCountries(for: worldStatsType)[sectionIndex].areas.isEmpty { return }
            
            if !ListData.shared.getCountries(for: worldStatsType)[sectionIndex].tableData.isEmpty {
                // Open already, close now
                
                // Closing this section so there will be no more another open section
                ListData.shared.setOpenSectionIndex(for: worldStatsType, index: nil)
                ListData.shared.removeTableData(section: sectionIndex, worldStatsType: worldStatsType)
                
                CATransaction.begin()
                CATransaction.setCompletionBlock {
                    if let headerView = self.mainView.tableView.headerView(forSection: sectionIndex) as? CountryHeaderView{
                        headerView.showClosed()
                    }
                }
                
                UIView.setAnimationsEnabled(false)
                mainView.tableView.beginUpdates()
                mainView.tableView.deleteRows(at: getIndexPaths(forSection: sectionIndex), with: .none)
                mainView.tableView.insertRows(at: [IndexPath(row: 0, section: sectionIndex)], with: .none)
                mainView.tableView.endUpdates()
                UIView.setAnimationsEnabled(true)
                self.mainView.tableView.scrollToRow(at: IndexPath(row: 0, section: sectionIndex), at: .none, animated: false)
                CATransaction.commit()
            }else{
                // Closed, open now
                let otherSectionOpenIndex = ListData.shared.getOpenSectionIndex(for: worldStatsType)
                ListData.shared.setOpenSectionIndex(for: worldStatsType, index: sectionIndex)
                
                if let otherSectionOpenIndex = otherSectionOpenIndex{
                    ListData.shared.removeTableData(section: otherSectionOpenIndex, worldStatsType: worldStatsType)
                    ListData.shared.addTableData(section: sectionIndex, worldStatsType: worldStatsType)
                    
                    CATransaction.begin()
                    CATransaction.setCompletionBlock {
                        if let headerView = self.mainView.tableView.headerView(forSection: otherSectionOpenIndex) as? CountryHeaderView{
                            headerView.showClosed()
                        }
                    }
                    
                    if let headerView = self.mainView.tableView.headerView(forSection: sectionIndex) as? CountryHeaderView{
                        headerView.showOpen()
                    }
                    
                    UIView.setAnimationsEnabled(false)
                    mainView.tableView.beginUpdates()
                    mainView.tableView.deleteRows(at: getIndexPaths(forSection: otherSectionOpenIndex), with: .none)
                    mainView.tableView.insertRows(at: [IndexPath(row: 0, section: otherSectionOpenIndex)], with: .none)
                    mainView.tableView.deleteRows(at: [IndexPath(row: 0, section: sectionIndex)], with: .none)
                    mainView.tableView.insertRows(at: getIndexPaths(forSection: sectionIndex), with: .none)
                    mainView.tableView.endUpdates()
                    UIView.setAnimationsEnabled(true)
                    mainView.tableView.scrollToRow(at: IndexPath(row: 0, section: sectionIndex), at: .none, animated: false)
                    CATransaction.commit()
                }else{
                    if let headerView = mainView.tableView.headerView(forSection: sectionIndex) as? CountryHeaderView{
                        headerView.showOpen()
                    }
                    
                    ListData.shared.addTableData(section: sectionIndex, worldStatsType: worldStatsType)
                    UIView.setAnimationsEnabled(false)
                    mainView.tableView.beginUpdates()
                    mainView.tableView.deleteRows(at: [IndexPath(row: 0, section: sectionIndex)], with: .none)
                    mainView.tableView.insertRows(at: getIndexPaths(forSection: sectionIndex), with: .none)
                    mainView.tableView.endUpdates()
                    UIView.setAnimationsEnabled(true)
                    mainView.tableView.scrollToRow(at: IndexPath(row: 0, section: sectionIndex), at: .none, animated: false)
                }
            }
        }
    }
    
    func getIndexPaths(forSection sectionIndex: Int) -> [IndexPath] {
        var indexPaths = [IndexPath]()
        
        for index in 0..<ListData.shared.getCountries(for: worldStatsType)[sectionIndex].areas.count{
            indexPaths.append(IndexPath(row: index, section: sectionIndex))
        }
        
        return indexPaths
    }
        
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow(at: indexPath)
    }
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        let dataCount = ListData.shared.getCountries(for: worldStatsType)[indexPath.section].tableData.count
        
        // First row will be zero height to avoid flickering issues if it's a closed section :)
        if dataCount == 0 {
            return 0
        }
        
        // Bigger row for top or bottom or single cell in section
        if (dataCount == 1) || (indexPath.row == 0 && indexPath.row + 1 < dataCount) || (indexPath.row == dataCount - 1 && indexPath.row - 1 >= 0) {
            return 45
        }else{
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
}

extension ListScreenVC: GADInterstitialDelegate {
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
    }
}
