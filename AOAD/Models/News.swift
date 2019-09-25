//
//  News.swift
//  AOAD
//
//  Created by Hassine on 11/09/2019.
//  Copyright © 2019 aoad. All rights reserved.
//

import Foundation

class News: NSObject {
    var id:Int = -1
    var title:String = ""
    var image:String = ""
    var date:String = ""
    var content:String = ""
    var link:String = ""
    var favorite:Bool = false
    
    override init() {
        
    }
    
    init(data:[String : Any]) {
        self.id = data["id"] as! Int
        self.title = data["name"] as! String
        self.image = data["description"] as! String
        self.date = data["date"] as! String
        self.content = data["propellant"] as! String
        self.link = data["link"] as! String
    }
}
