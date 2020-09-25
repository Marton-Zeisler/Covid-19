//
//  MapScreenView.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 12..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import UIKit
import GoogleMaps

class MapScreenView: BaseView {
        
    let camera: GMSCameraPosition = {
        return GMSCameraPosition.camera(withLatitude: 32.59441100346494, longitude: 112.59924408048391, zoom: 5.05207)
    }()
    
    lazy var mapView: GMSMapView = {
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.settings.rotateGestures = false
        
        do{
            if let styleURL = Bundle.main.url(forResource: "mapStyle", withExtension: "json"){
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            }
        }catch{
            print("Google Maps styling failed")
        }
        
        mapView.backgroundColor = .black
        return mapView
    }()
    
    let mainStatsView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.setShadows(shadowColor: #colorLiteral(red: 0.2980392157, green: 0.2980392157, blue: 0.2980392157, alpha: 1), shadowOpacity: 0.5, shadowOffset: CGPoint(x: 0, y: 2), shadowBlur: 10)
        return view
    }()
    
    let worldStatsLabel: UILabel = {
        let label = UILabel()
        label.text = "WORLDWIDE STATISTICS"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.backgroundColor = #colorLiteral(red: 0.8705882353, green: 0.4078431373, blue: 0.4745098039, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    let lowerStatsView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.7529411765, green: 0.2392156863, blue: 0.2980392157, alpha: 1)
        return view
    }()
    
    let confirmedCasesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Confirmed Cases"
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    let confirmedCasesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 27, weight: .semibold)
        label.textAlignment = .center
        label.text = "0"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var confirmedStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [confirmedCasesTitleLabel, confirmedCasesLabel])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 6
        stack.alignment = .fill
        return stack
    }()
    
    let deathsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Deaths"
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.minimumScaleFactor = 0.7
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    let deathsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 27, weight: .semibold)
        label.textAlignment = .center
        label.text = "0"
        return label
    }()
    
    lazy var deathsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [deathsTitleLabel, deathsLabel])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.spacing = 6
        return stack
    }()
    
    let lastUpdateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 8, weight: .light)
        return label
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.opacity = 0.37
        return view
    }()
    
    let circleView: CircleView = {
        return CircleView()
    }()
    
    let noInternetView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.6392156862745098, green: 0.2, blue: 0.24705882352941178, alpha: 1)
        view.layer.cornerRadius = 8
        view.setShadows(shadowColor: .black, shadowOpacity: 0.5, shadowOffset: CGPoint(x: 0, y: 2), shadowBlur: 4)
        
        let label = UILabel()
        label.text = "No Internet"
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        
        view.addSubview(label)
        label.center(toVertically: view, toHorizontally: view)
        return view
    }()
    
    override func setupViews() {
        addSubview(mapView)
        mapView.fillSuperView()
        
        addSubview(mainStatsView)
        mainStatsView.setAnchors(top: nil, leading: leadingAnchor, trailing: trailingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, topConstant: nil, leadingConstant: 20, trailingConstant: 20, bottomConstant: 30)
        
        mainStatsView.addSubview(worldStatsLabel)
        worldStatsLabel.setAnchors(top: mainStatsView.topAnchor, leading: mainStatsView.leadingAnchor, trailing: mainStatsView.trailingAnchor, bottom: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: nil)
        worldStatsLabel.setAnchorSize(width: nil, height: 42)
        
        mainStatsView.addSubview(lowerStatsView)
        lowerStatsView.setAnchors(top: worldStatsLabel.bottomAnchor, leading: mainStatsView.leadingAnchor, trailing: mainStatsView.trailingAnchor, bottom: mainStatsView.bottomAnchor, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0)
        lowerStatsView.setAnchorSize(width: nil, height: 120)
        
        lowerStatsView.addSubview(lastUpdateLabel)
        lastUpdateLabel.setAnchors(top: nil, leading: nil, trailing: nil, bottom: lowerStatsView.bottomAnchor, topConstant: nil, leadingConstant: nil, trailingConstant: nil, bottomConstant: 12)
        lastUpdateLabel.center(toVertically: nil, toHorizontally: lowerStatsView)

        lowerStatsView.addSubview(lineView)
        lineView.centerWithConstant(toVertically: lowerStatsView, toHorizontally: lowerStatsView, verticalConstant: -10, horizontatlConstant: 0)
        lineView.setAnchorSize(to: lowerStatsView, widthMultiplier: nil, heightMultiplier: 0.55)
        lineView.setAnchorSize(width: 1, height: nil)
        
        lowerStatsView.addSubview(confirmedStack)
        confirmedStack.center(toVertically: lineView, toHorizontally: nil)
        confirmedStack.setAnchors(top: nil, leading: lowerStatsView.leadingAnchor, trailing: lineView.leadingAnchor, bottom: nil, topConstant: nil, leadingConstant: 8, trailingConstant: 8, bottomConstant: nil)
        
        lowerStatsView.addSubview(deathsStack)
        deathsStack.center(toVertically: lineView, toHorizontally: nil)
        deathsStack.setAnchors(top: nil, leading: lineView.trailingAnchor, trailing: lowerStatsView.trailingAnchor, bottom: nil, topConstant: nil, leadingConstant: 8, trailingConstant: 8, bottomConstant: nil)
    }
    
    func showNoInternetView(){
        addSubview(noInternetView)
        noInternetView.setAnchors(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: nil, topConstant: 10, leadingConstant: 20, trailingConstant: 20, bottomConstant: nil)
        noInternetView.setAnchorSize(width: nil, height: 50)
    }
    
    func hideNoInternetView(){
        noInternetView.removeFromSuperview()
    }
    
    func setupData(allData: AllData){
        confirmedCasesLabel.text = ListData.shared.worldWideCases.delimiter
        deathsLabel.text = ListData.shared.worldWideDeaths.delimiter
        
        if let updateDateString = allData.update{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            guard let date = dateFormatter.date(from: updateDateString) else { return }
            dateFormatter.dateFormat = "MMMM dd, yyyy"
            let updateText = "Last Updated: \(dateFormatter.string(from: date))"
            lastUpdateLabel.text = updateText
            ListData.shared.updateDateString = updateText
        }
    }
    
    
}
