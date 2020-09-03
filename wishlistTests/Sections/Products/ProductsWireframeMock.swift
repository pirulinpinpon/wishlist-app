//
//  ProductsWireframeMock.swift
//  wishlistTests
//
//  Created by Jerilyn Gonçalves on 30/08/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import UIKit
@testable import wishlist

class ProductsWireframeMock: ProductsWireframeProtocol {
    
    // MARK: - Spies

    var spyShowProducts: (called: Bool, navigationController: UINavigationController?) = (called: false, navigationController: nil)
    var spyShowProductDetail: (called: Bool, product: Product?) = (called: false, product: nil)
    var spyDismissProductDetailCalled: Bool = false
    var spyShowAddProductCalled: Bool = false
    var spyDismissAddProductCalled: Bool = false
    var spyShowUpdateProductCalled: Bool = false
    var spyDismissUpdateProductCalled: Bool = false
    var spyOpenURL: (called: Bool, url: URL?) = (called: false, url: nil)
    
    // MARK: - ProductsWireframeProtocol

    func showProducts(in navigationController: UINavigationController) {
        self.spyShowProducts = (called: true, navigationController: navigationController)
    }
    
    func showProductDetail(_ product: Product) {
        self.spyShowProductDetail = (called: true, product: product)
    }
    
    func dismissProductDetail() {
        self.spyDismissProductDetailCalled = true
    }
    
    func showAddProduct() {
        self.spyShowAddProductCalled = true
    }
    
    func dismissAddProduct() {
        self.spyDismissAddProductCalled = true
      }
    
    func showUpdateProduct(_ product: Product) {
        self.spyShowUpdateProductCalled = true
    }
    
    func dismissUpdateProduct() {
        self.spyDismissUpdateProductCalled = true
    }
    
    func openURL(_ url: URL) {
        self.spyOpenURL = (called: true, url: url)
    }
}
