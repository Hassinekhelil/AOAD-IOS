//
//  Country.swift
//  AOAD
//
//  Created by Hassine on 12/09/2019.
//  Copyright © 2019 aoad. All rights reserved.
//

import Foundation
import SwiftyJSON

class Country: NSObject {
    var name:String = ""
    var flag:String = ""
    var region:String = ""
    
    override init() {}
    
    init(data:[String : Any]) {
        self.name = data["name"] as! String
        self.flag = data["description"] as! String
        self.region = data["date"] as! String
    }
    
    init(data : JSON) {
        self.name = data["lib_pays"].string!
        self.flag = "http://aoadstat.org/"+data["drap"].string!
        self.region = data["region"].string!
    }
}
