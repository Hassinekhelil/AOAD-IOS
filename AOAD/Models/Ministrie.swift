//
//  Ministrie.swift
//  AOAD
//
//  Created by Hassine on 25/09/2019.
//  Copyright © 2019 aoad. All rights reserved.
//

import Foundation
import SwiftyJSON

class Ministrie: NSObject {
    
    var country_en:String = ""
    var country_ar:String = ""
    var region_en:String = ""
    var region_ar:String = ""
    var link:String = ""
    var lat:String = ""
    var lng:String = ""
    
    override init() {
        
    }
    
    init(data : JSON) {
        country_en = data["lib_pays_en"].string!
        region_en = data["region_ar"].string!
        country_ar = data["lib_pays"].string!
        region_ar = data["region"].string!
        lat = data["Latitude"].string!
        lng = data["Longitude"].string!
        link = data["link"].string!
    }
}
