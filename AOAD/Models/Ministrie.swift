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
    
    var country:String = ""
    var region:String = ""
    var link:String = ""
    var lat:String = ""
    var lng:String = ""
    
    override init() {
        
    }
    
    init(data : JSON) {
        country = data["lib_pays_en"].string!
        lat = data["Latitude"].string!
        lng = data["Longitude"].string!
        region = data["Longitude"].string!
        link = data["Longitude"].string!
    }
}
