//
//  AppDelegate.swift
//  wishlist
//
//  Created by Jerilyn Gonçalves on 28/08/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appController = AppController.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.prepareAppController(application)
        
        return true
    }
    
    // MARK: - Private Helpers
    
    fileprivate func prepareAppController(_ application: UIApplication) {
        let appController = AppController.shared
        appController.appWireframe = AppWireframe()
        appController.appWireframe?.window = self.window
        AppController.shared.appDidLaunch(application)
    }
}
