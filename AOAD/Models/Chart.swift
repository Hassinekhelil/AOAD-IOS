//
//  Chart.swift
//  AOAD
//
//  Created by Hassine on 25/09/2019.
//  Copyright © 2019 aoad. All rights reserved.
//

import Foundation

class Chart: NSObject {
    
    var title:String = ""
    var years = [String]()
    var values = [Double]()
    var values1 = [Double]()
    var values2 = [Double]()
    var values3 = [Double]()
    var values4 = [Double]()
    
    init(title: String, years : [String], values : [Double], values1 : [Double], values2 : [Double], values3 : [Double], values4 : [Double]) {
       
        self.title = title
        self.years = years
        self.values = values
        self.values1 = values1
        self.values2 = values2
        self.values3 = values3
        self.values4 = values4
    }

}
