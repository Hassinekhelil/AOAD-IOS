//
//  ContactUsViewController.swift
//  AOAD
//
//  Created by Hassine on 25/09/2019.
//  Copyright © 2019 aoad. All rights reserved.
//

import UIKit
import GoogleMaps

class ContactUsViewController: UIViewController {

    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var fax: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    var choice:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.title = choice
        
        adress.text = "adress".localized(using: "Localizable")
        phone.text = "phone".localized(using: "Localizable")
        fax.text = "fax".localized(using: "Localizable")
        
        addMarker()
    }
    
    func addMarker() {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 15.5828573 , longitude: 32.5465546 )
        marker.title = "General Directorate of the Organization for Agricultural Development".localized(using: "Localizable")
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
