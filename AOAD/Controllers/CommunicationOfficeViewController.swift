//
//  CommunicationOfficeViewController.swift
//  AOAD
//
//  Created by Hassine on 25/09/2019.
//  Copyright © 2019 aoad. All rights reserved.
//

import UIKit
import GoogleMaps
import SwitchLanguage


class CommunicationOfficeViewController: UIViewController, GMSMapViewDelegate {

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
        
        getCommunicationOffice()
    }
    
    func getCommunicationOffice()  {
        let params = [
            "lng": Language.getCurrentLanguage()
        ]
        
        NetworkManager.getCommunicationOffice(param: params as NSDictionary) { (error, data)  in
            for item in data {
                self.addMarker(item: item)
            }
            let camera = GMSCameraPosition.camera(withLatitude: Double(data[0].lat)!, longitude: Double(data[0].lng)!, zoom: 3)
            self.mapView.isMyLocationEnabled = true
            self.mapView.camera = camera
        }
    }
    
    func addMarker(item: CommunicationOffice) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: Double(item.lat)! , longitude: Double(item.lng)! )
        marker.title = item.country
        marker.snippet = "Region".localized(using: "Localizable") + item.region + "\n" + "Chef".localized(using: "Localizable") + item.chef + "\n" + "Tel".localized(using: "Localizable") + item.tel + "\n" + "Fax".localized(using: "Localizable") + item.fax + "\n" + "Email".localized(using: "Localizable") + item.email + "\n" + "Address".localized(using: "Localizable") + item.adress
        marker.icon = GMSMarker.markerImage(with: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))
        marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.4)
        marker.map = mapView
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let infoWindow = Bundle.main.loadNibNamed("CustomInfoWindow", owner: self, options: nil)?.first! as! CustomInfoWindow
        infoWindow.label.text = marker.title
        infoWindow.desc.text = marker.snippet
        return infoWindow
    }

}
