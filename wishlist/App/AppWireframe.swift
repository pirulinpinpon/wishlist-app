//
//  AppWireframe.swift
//  wishlist
//
//  Created by Jerilyn Gonçalves on 29/08/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import UIKit

protocol AppWireframeProtocol {
    
    var window: UIWindow? { get set }
    func showProducts()
}

class AppWireframe: AppWireframeProtocol {
    
    var window: UIWindow?
    var navigationController: UINavigationController?
        
    func showProducts() {
        let navigationController = UINavigationController()
        self.navigationController = navigationController
        ProductsWireframe().showProducts(in: navigationController)
        
        self.window?.rootViewController = self.navigationController
    }
}
