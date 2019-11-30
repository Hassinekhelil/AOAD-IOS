//
//  MinistriesViewController.swift
//  AOAD
//
//  Created by Hassine on 25/09/2019.
//  Copyright © 2019 aoad. All rights reserved.
//

import UIKit
import GoogleMaps
import SwitchLanguage


class MinistriesViewController: UIViewController, GMSMapViewDelegate {

    var choice:String = ""    
    @IBOutlet weak var mapView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.title = choice
        
        mapView.delegate = self

        getMinistries()
    }
    
    func getMinistries()  {
        let params = [
            "annee1": "",
            "annee2": ""
        ]
        
        NetworkManager.getMinistires(param: params as NSDictionary) { (error, data)  in
            for item in data {
                self.addMarker(item: item)
            }
            let camera = GMSCameraPosition.camera(withLatitude: Double(data[0].lat)!, longitude: Double(data[0].lng)!, zoom: 3)
            self.mapView.isMyLocationEnabled = true
            self.mapView.camera = camera
        }
    }
    
    func addMarker(item: Ministrie) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: Double(item.lat)! , longitude: Double(item.lng)! )
        switch item.region_en {
        case "Arab Orient":
            marker.icon = GMSMarker.markerImage(with: #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))
        case "Arabian Peninsula":
            marker.icon = GMSMarker.markerImage(with: #colorLiteral(red: 0.9254902005, green: 0, blue: 0.1019607857, alpha: 1))
        case "Arab Maghreb":
            marker.icon = GMSMarker.markerImage(with: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
        case "Middle":
            marker.icon = GMSMarker.markerImage(with: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))
        default:
            marker.icon = GMSMarker.markerImage(with: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))
        }
        
        switch Language.getCurrentLanguage() {
        case "ar":
            marker.title = item.country_ar
            marker.snippet = "Region".localized(using: "Localizable") + item.region_ar + "\n" + "Click".localized(using: "Localizable")
        case "fr", "en":
            marker.title = item.country_en
            marker.snippet = "Region".localized(using: "Localizable") + item.region_en + "\n" + "Click".localized(using: "Localizable")
        default:
            marker.title = item.country_en
            marker.snippet = "Region".localized(using: "Localizable") + item.region_en + "\n" + "Click".localized(using: "Localizable")
        }
        marker.userData = item.link
        marker.map = mapView
    }

    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        guard let url = URL(string: marker.userData as! String) else { return }
        UIApplication.shared.open(url)
    }
}
