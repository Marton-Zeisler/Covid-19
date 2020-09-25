//
//  ListSearchResultsVC.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 16..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import UIKit

class ListSearchResultsVC: UIViewController, UISearchResultsUpdating {

    var mainView: ListSearchResultsView!
    var tableData = [SearchData]()
    
    var keyboardHeight: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        if let keyboardHeight = keyboardHeight{
            mainView.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight - view.safeAreaInsets.bottom, right: 0)
            mainView.tableView.scrollIndicatorInsets = mainView.tableView.contentInset
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    override func loadView() {
        mainView = ListSearchResultsView()
        self.view = mainView
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        view.isHidden = false
        
        let text = (searchController.searchBar.text ?? "").lowercased()
        
        if text.count == 0{
            tableData.removeAll()
            mainView.tableView.reloadData()
            mainView.noResultsLabel.isHidden = true
        }else{
            tableData = ListData.shared.searchData.filter { return $0.title.lowercased().contains(text) }
            mainView.tableView.reloadData()
            mainView.noResultsLabel.isHidden = !tableData.isEmpty
        }
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            mainView.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        } else {
            mainView.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }

        mainView.tableView.scrollIndicatorInsets = mainView.tableView.contentInset
    }

}

extension ListSearchResultsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SearchCell else { return UITableViewCell() }
        cell.setupData(searchData: tableData[indexPath.row])
        return cell
    }
}
