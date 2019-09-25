//
//  PrefManager.swift
//  AOAD
//
//  Created by Hassine on 03/09/2019.
//  Copyright © 2019 aoad. All rights reserved.
//

import Foundation

class PrefManager{
    
    static var prefManager  = PrefManager ()
    var prefs:UserDefaults = UserDefaults.standard
    
    private init() {}

    func setToPref(key: String, value: String) {
        prefs.set(value, forKey: key)
        prefs.synchronize()
    }
    
    func getFromPref(key: String) -> String {
        return prefs.string(forKey: key) ?? ""
    }
}
