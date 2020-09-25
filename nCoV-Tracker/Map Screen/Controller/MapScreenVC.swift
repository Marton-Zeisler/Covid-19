//
//  MapScreenVC.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 12..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import UIKit
import GoogleMaps
import GoogleMobileAds
import Network

class MapScreenVC: UIViewController, GMSMapViewDelegate {

    var mainView: MapScreenView!
    var allData: AllData?
    var markers = [GMSMarker: AreaData]()
    var detailView: DetailMarkerView?
    var tappedMarker: GMSMarker?
    
    var bannerView: GADBannerView!
    var interstitial: GADInterstitial!
    var dataAfterInterstitial: (marker: GMSMarker, areaData: AreaData, mapView: GMSMapView)?
    
    let monitor = NWPathMonitor()
    var dataDownloadedFromServer = false
    var dataLoadedFromLocal = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.mapView.delegate = self
        loadData()
        
        if !Static.purchased{
            interstitial = createAndLoadInterstitial()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(removeAdsPurchased), name: .removeAds, object: nil)
        
        if let zoom = UserDefaults.standard.value(forKey: "zoom") as? Float, let lat = UserDefaults.standard.value(forKey: "lat") as? CLLocationDegrees, let long = UserDefaults.standard.value(forKey: "long") as? CLLocationDegrees{
            print(zoom)
            print(long)
            print(lat)
            mainView.mapView.animate(to: GMSCameraPosition(latitude: lat, longitude: long, zoom: zoom))
        }
        
        if let lat = UserDefaults.standard.value(forKey: "lat") as? Double, let long = UserDefaults.standard.value(forKey: "long") as? Double, let zoom = UserDefaults.standard.value(forKey: "zoom") as? Float {
            mainView.mapView.animate(to: GMSCameraPosition(latitude: lat, longitude: long, zoom: zoom))
        }
    }
    
    @objc func removeAdsPurchased(){
        bannerView?.removeFromSuperview()
    }
    
    func saveMapData(){
        Static.mapLat = mainView.mapView.camera.target.latitude
        Static.mapLong = mainView.mapView.camera.target.longitude
        Static.mapZoom = mainView.mapView.camera.zoom
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: Static.intersitialID)
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
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
    
    override func loadView() {
        mainView = MapScreenView()
        self.view = mainView
    }
    
    func loadData(){
        Network.shared.downloadData { (allData) in
            if let allData = allData{
                self.dataDownloadedFromServer = true
                DataManager.shared.updateLocalData(allData: allData)
                self.updateUI(allData: allData)
            }else{
                if !self.dataLoadedFromLocal{
                    self.dataLoadedFromLocal = true
                    self.loadDataLocally()
                }
                
                self.checkInternet()
            }
        }
    }
     
    func loadDataLocally(){
        DataManager.shared.getLocalData { (allData) in
            if let allData = allData {
                self.updateUI(allData: allData)
            }
        }
    }
    
    func checkInternet(){
        // Couldn't load data from server
        monitor.pathUpdateHandler = { path in
            print(path.status)
            if path.status == .satisfied{
                // Internet is back
                DispatchQueue.main.async {
                    self.mainView.hideNoInternetView()
                }
                self.monitor.cancel()
                self.loadData()
            }else{
                DispatchQueue.main.async {
                    if self.mainView.noInternetView.superview == nil {
                        self.mainView.showNoInternetView()
                    }
                }
            }
        }
        
        monitor.start(queue: DispatchQueue.global(qos: .userInteractive))
    }

    func updateUI(allData: AllData){        
        markers.removeAll()
        ListData.shared.reset()
        allData.data?.forEach({ ListData.shared.addAreaData($0) })
        self.allData = allData
        
        DispatchQueue.main.async {
            self.mainView.setupData(allData: allData)
            self.mainView.mapView.clear()
            self.showMarkers()
            
            
            ((self.tabBarController?.viewControllers?[1] as? UINavigationController)?.topViewController as? ListScreenVC)?.loadDataUI()
         }
    }
    
    func showMarkers(){
        guard let data  = allData?.data else { return }
        var index = 0
        
        for eachAreaData in data {
            guard let lat = eachAreaData.lat, let long = eachAreaData.long else { continue }
            if index == data.count - 1{
                print()
            }
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
            var size = 30
            switch eachAreaData.cases {
            case 0...100:
                size = 30
            case 101...200:
                size = 40
            case 201...500:
                size = 50
            default:
                size = 60
            }
            
            marker.iconView = CircleView(frame: CGRect(x: 0, y: 0, width: size, height: size))
            marker.appearAnimation = .pop
            marker.tracksViewChanges = false
            self.markers[marker] = eachAreaData
            
            marker.map = self.mainView.mapView
            index += 1
        }
        
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        // Removing previous detail view if exists
        detailView?.removeFromSuperview()
        detailView = nil
        
        tappedMarker = marker
        mapView.animate(toLocation: CLLocationCoordinate2D(latitude: marker.position.latitude, longitude: marker.position.longitude + 1.2))
        return true
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        saveMapData()
        
        if let marker = tappedMarker, let areaData = markers[marker] {
            if interstitial != nil && interstitial.isReady && Static.timeToShowAd && !Static.purchased{
                dataAfterInterstitial = (marker, areaData, mapView)
                interstitial.present(fromRootViewController: self)
            }else{
                showDetailView(marker: marker, areaData: areaData, mapView: mapView)
            }
            
            Static.userInteractionsCounter += 1
        }
    }
    
    func showDetailView(marker: GMSMarker, areaData: AreaData, mapView: GMSMapView){
        let areaText = areaData.formattedTitle
        let areaTextHeight = areaText.height(withConstrainedWidth: 184-32, font: .systemFont(ofSize: 15, weight: .semibold))
        let height: CGFloat = areaTextHeight <= 20 ? 150 : 170
        
        let markerPoint = mapView.projection.point(for: marker.position)
        let markerSize = marker.iconView?.frame.height ?? 30
        let x = markerPoint.x - 2
        let y = markerPoint.y - (markerSize/2) - height + 5
        
        let detailView = DetailMarkerView(frame: CGRect(x: x, y: y, width: 184, height: height))
        detailView.setupData(areaData: areaData)
        mainView.addSubview(detailView)
        self.detailView = detailView

        tappedMarker = nil
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        detailView?.removeFromSuperview()
        detailView = nil
    }
        
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        detailView?.removeFromSuperview()
        detailView = nil
    }
    
    
    
    
    
}

extension MapScreenVC: GADBannerViewDelegate, GADInterstitialDelegate {
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        if bannerView.superview == nil{
            mainView.addSubview(bannerView)
            bannerView.setAnchors(top: mainView.safeAreaLayoutGuide.topAnchor, leading: nil, trailing: nil, bottom: nil, topConstant: 0, leadingConstant: nil, trailingConstant: nil, bottomConstant: nil)
            bannerView.center(toVertically: nil, toHorizontally: mainView)
        }
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        if let marker = dataAfterInterstitial?.marker, let areaData = dataAfterInterstitial?.areaData, let mapView = dataAfterInterstitial?.mapView{
            showDetailView(marker: marker, areaData: areaData, mapView: mapView)
            dataAfterInterstitial = nil
        }
    
        interstitial = createAndLoadInterstitial()
    }
    
}


