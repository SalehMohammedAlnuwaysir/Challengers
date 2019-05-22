//
//  AppDelegate.swift
//  Challengers
//
//  Created by YAZEED NASSER on 22/09/2018.
//  Copyright © 2018 YAZEED NASSER. All rights reserved.
//

import UIKit
import Firebase
import CoreData

let primaryColor = UIColor(red: 0.86, green: 0.68, blue: 0.05, alpha: 1)
let secondaryColor = UIColor(red: 0.88, green: 0.06, blue: 0.07, alpha: 1)

let OptionButtenColor = UIColor(red: 0.98, green: 0.76, blue: 0.09, alpha: 0.8)
let GoButtenColor = UIColor(red: 0.65, green: 0.30, blue: 0.47, alpha: 0.8)
let BackButtenColor = UIColor(red: 0.95, green: 0.16, blue: 0.03, alpha: 0.8)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var firebaseRef: DatabaseReference!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        firebaseRef = Database.database().reference()
        /*window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: ProfileVC(nibName: "ProfileVC", bundle: nil))
        navigationController.isNavigationBarHidden = true
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()*/
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
}

