//
//  TabBarController.swift
//  Challengers
//
//  Created by Saleh on 26/01/1440 AH.
//  Copyright © 1440 YAZEED NASSER. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    @IBInspectable var defaultIndex: Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = defaultIndex
        
    }
}
