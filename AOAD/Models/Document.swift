//
//  Document.swift
//  AOAD
//
//  Created by Hassine on 13/09/2019.
//  Copyright © 2019 aoad. All rights reserved.
//

import Foundation

class Documuent: NSObject {
    var title:String = ""
    var image:String = ""
    var date:String = ""
    var link:String = ""
    
    override init() {}
    
    init(data:[String : Any]) {
        self.image = data["url_img"] as! String
        self.title = data["name"] as! String
        self.date = data["datedoc"] as! String
        self.link = data["url_pdf"] as! String
    }
}
