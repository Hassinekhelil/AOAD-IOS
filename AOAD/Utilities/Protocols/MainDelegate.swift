//
//  MainDelegate.swift
//  AOAD
//
//  Created by Hassine on 10/09/2019.
//  Copyright © 2019 aoad. All rights reserved.
//

import UIKit

@objc
protocol MainDelegate {
    @objc optional func toggleLeftPanel()
    @objc optional func toggleRightPanel()
    @objc optional func collapseSidePanels()
}
