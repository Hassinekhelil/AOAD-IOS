//
//  Network&DB.swift
//  AOAD
//
//  Created by Hassine on 13/09/2019.
//  Copyright © 2019 aoad. All rights reserved.
//

import Foundation

class NetworkDB: NSObject {
    var title:String = ""
    var image:String = ""
    var link:String = ""
    
    override init() {}
    
    init(data:[String : Any]) {
        self.image = data["imgurl"] as! String
        self.title = data["title"] as! String
        self.link = data["url_bd"] as! String
    }
}
