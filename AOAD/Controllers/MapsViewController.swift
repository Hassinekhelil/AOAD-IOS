//
//  MapsViewController.swift
//  AOAD
//
//  Created by Hassine on 02/09/2019.
//  Copyright © 2019 aoad. All rights reserved.
//

import UIKit
import GoogleMaps
import SwiftyJSON

class MapsViewController: UIViewController, UIStepperControllerDelegate {
    
    var choice:String = ""
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var dateOfLabel: UILabel!
    @IBOutlet weak var dateOfStepper: UIStepperController!
    @IBOutlet weak var dateToLabel: UILabel!
    @IBOutlet weak var dateToStepper: UIStepperController!
    @IBOutlet weak var validateBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.title = choice
        
        dateOfLabel.text = "Date of :".localized(using: "Localizable")
        dateToLabel.text = "Date to :".localized(using: "Localizable")
        validateBtn.setTitle("Validate statistics".localized(using: "Localizable"), for: .normal)

        
        self.dateToStepper.delegate = self
        self.dateToStepper.tag = 10001
        self.dateToStepper.incrementBy(number: 1)
        self.dateToStepper.textColor(color: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
        self.dateToStepper.count = 2019
        
        self.dateOfStepper.delegate = self
        self.dateOfStepper.tag = 10002
        self.dateOfStepper.incrementBy(number: 1)
        self.dateOfStepper.textColor(color: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
        self.dateOfStepper.count = 2015
        
    }
    
    func stepperDidAddValues(stepper: UIStepperController) {
//        switch stepper.tag {
//        case 10001:
//            print("Stepper 10001 value did change (Add) : \(stepper.count)")
//            break
//        case 10002:
//            print("Stepper 10002 value did change (Add) : \(stepper.count)")
//            break
//        default:
//            break
//        }
        getList()
    }
    
    func stepperDidSubtractValues(stepper: UIStepperController) {
        getList()
    }
    
    func getList()  {
        let params = [
            "annee1": self.dateOfStepper.count,
            "annee2": self.dateToStepper.count
        ]
        
        NetworkManager.getMarkersPositions(param: params as NSDictionary) { (error, data)  in
            for item in data {
                self.addMarker(title: item.name, lat: item.lat, lng: item.lng)
            }
            let camera = GMSCameraPosition.camera(withLatitude: Double(data[0].lat)!, longitude: Double(data[0].lng)!, zoom: 3)
            self.mapView.isMyLocationEnabled = true
            self.mapView.camera = camera
        }
    }
    
    func addMarker(title: String, lat: String, lng: String) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: Double(lat)! , longitude: Double(lng)! )
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
