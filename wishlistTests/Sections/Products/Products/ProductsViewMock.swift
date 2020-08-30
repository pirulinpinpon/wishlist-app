//
//  ProductsViewMock.swift
//  wishlistTests
//
//  Created by Jerilyn Gonçalves on 30/08/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import Foundation
@testable import wishlist


class ProductsViewMock: ProductsUI {
        
    // MARK: - Spies
    
    var spyShowInitialLoaderCalled: Bool = false
    var spyDismissInitialLoaderCalled: Bool = false
    var spyShowProductsCalled: Bool = false
    var spyShowAlert: (called: Bool, title: String?, message: String?) = (called: false, title: nil, message: nil)
    
    // MARK: - ProductsUI
    
    func showInitialLoader() {
        self.spyShowInitialLoaderCalled = true
    }
    
    func dismissInitialLoader() {
        self.spyDismissInitialLoaderCalled = true
    }
    
    func showProducts() {
        self.spyShowProductsCalled = true
    }
    
    func showAlert(title: String, message: String) {
        self.spyShowAlert = (called: true, title: title, message: message)
    }
}
