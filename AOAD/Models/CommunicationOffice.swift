//
//  CommunicationOffice.swift
//  AOAD
//
//  Created by Hassine on 24/09/2019.
//  Copyright © 2019 aoad. All rights reserved.
//

import Foundation
import SwiftyJSON

class CommunicationOffice: NSObject {
    
    var country:String = ""
    var region:String = ""
    var chef:String = ""
    var tel:String = ""
    var fax:String = ""
    var email:String = ""
    var adress:String = ""
    var lat:String = ""
    var lng:String = ""
    
    override init() {
        
    }
    
    init(data : JSON) {
        country = data["lib_pays"].string!
        lat = data["Latitude"].string!
        lng = data["Longitude"].string!
        region = data["region"].string!
        chef = data["chef_b"].string!
        tel = data["tel_b"].string!
        fax = data["fax_b"].string!
        email = data["email_b"].string!
        adress = data["adresse_b"].string!
    }
}
