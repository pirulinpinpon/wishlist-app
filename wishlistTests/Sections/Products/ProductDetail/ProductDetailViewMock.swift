//
//  ProductDetailViewMock.swift
//  wishlistTests
//
//  Created by Jerilyn Gonçalves on 03/09/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import Foundation
@testable import wishlist


class ProductDetailViewMock: ProductDetailUI {
    
    // MARK: - Spies
    
    var spyLoadProduct: (product: Product?, called: Bool) = (product: nil, called: false)
    var spyShowLoadingCalled: Bool = false
    var spyDismissLoadingCalled: Bool = false
    var spyShowAlert: (called: Bool, title: String?, message: String?) = (called: false, title: nil, message: nil)
    
    // MARK: - ProductDetailUI
    
    func loadProduct(_ product: Product) {
        self.spyLoadProduct = (product: product, called: true)
    }
    
    func showAlert(title: String, message: String, continueAction: AlertAction, cancelAction: AlertAction) {
        self.spyShowAlert = (called: true, title: title, message: message)
    }
    
    func showLoading() {
        self.spyShowLoadingCalled = true
    }
    
    func dismissLoading() {
        self.spyDismissLoadingCalled = true
    }
}
