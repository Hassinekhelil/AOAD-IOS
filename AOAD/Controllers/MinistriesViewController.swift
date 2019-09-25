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


class MinistriesViewController: UIViewController {

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
        marker.title = title
        //marker.snippet = "Australia"
        marker.map = mapView
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}
