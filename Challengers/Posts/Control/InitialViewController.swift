//
//  InitialViewController.swift
//  CloudFunctions
//
//  Created by Robert Canton on 2017-09-13.
//  Copyright © 2017 Robert Canton. All rights reserved.
//

import Foundation
import UIKit

class InitialViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //- Todo: Check if user is authenticated(signed in). If so, segue to the HomeVC, otherwise, segue to the WelcomeVC
     
        self.performSegue(withIdentifier: "WelcomeVC", sender: self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
}
