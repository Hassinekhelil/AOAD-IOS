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
        country = data["lib_pays_en"].string!
        lat = data["Latitude"].string!
        lng = data["Longitude"].string!
        region = data["Longitude"].string!
        chef = data["Longitude"].string!
        tel = data["Longitude"].string!
        fax = data["Longitude"].string!
        email = data["Longitude"].string!
        adress = data["Longitude"].string!
    }
}
