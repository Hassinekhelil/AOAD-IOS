//
//  Item.swift
//  AOAD
//
//  Created by Hassine on 26/11/2019.
//  Copyright © 2019 aoad. All rights reserved.
//

import Foundation

class Item: NSObject {
    
    var name:String = ""
    var checked:Bool = false
    
    override init() {
        
    }
    
    init(name: String, checked: Bool) {
        self.name = name
        self.checked = checked
    }
}
