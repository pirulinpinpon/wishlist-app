//
//  AppController.swift
//  wishlist
//
//  Created by Jerilyn Gonçalves on 29/08/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import UIKit

protocol AppControllerProtocol {
    func appDidLaunch(_ application: UIApplication)
}

class AppController: AppControllerProtocol {
    
    // MARK: Singleton
    
    static let shared = AppController()
    
    // MARK: Public properties
    
    var appWireframe: AppWireframe?
    
    // MARK: - AppControllerProtocol
    
    func appDidLaunch(_ application: UIApplication) {
        self.appWireframe?.showProducts()
    }
}
