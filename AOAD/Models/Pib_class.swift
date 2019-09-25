//
//  Pib_class.swift
//  AOAD
//
//  Created by Hassine on 05/09/2019.
//  Copyright © 2019 aoad. All rights reserved.
//

import Foundation
import SwiftyJSON

class Pib_class: NSObject {
    
    var name:String = ""
    var lat:String = ""
    var lng:String = ""
    
    override init() {
        
    }
    
    init(data : JSON) {
        name = data["lib_pays_en"].string!
        lat = data["Latitude"].string!
        lng = data["Longitude"].string!
    }
}
