//
//  WelcomeVC.swift
//  Challengers
//
//  Created by YAZEED NASSER on 23/09/2018.
//  Copyright © 2018 YAZEED NASSER. All rights reserved.
//

import UIKit
import UserNotifications
class WelcomeVC: UIViewController {
    
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        loginBtn.backgroundColor = GoButtenColor
        registerBtn.backgroundColor = BackButtenColor
        
        //notifcation allert!!

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
        })
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
