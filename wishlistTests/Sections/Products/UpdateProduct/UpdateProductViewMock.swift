//
//  UpdateProductViewMock.swift
//  wishlistTests
//
//  Created by Jerilyn Gonçalves on 03/09/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import Foundation
@testable import wishlist


class UpdateProductViewMock: UpdateProductUI {
    
    // MARK: - Spies
    
    var spyLoadForUpdate: (product: Product?, called: Bool) = (product: nil, called: false)
    var spyLoadForAddCalled: Bool = false
    var spyEnableUpdateButtonCalled: Bool = false
    var spyDisableUpdateButtonCalled: Bool = false
    var spyShowLoadingCalled: Bool = false
    var spyDismissLoadingCalled: Bool = false
    
    // MARK: - UpdateProductUI
    
    func loadForUpdate(_ product: Product) {
        self.spyLoadForUpdate = (product: product, called: true)
    }
    
    func loadForAdd() {
        self.spyLoadForAddCalled = true
    }
    
    func enableUpdateButton() {
        self.spyEnableUpdateButtonCalled = true
    }
    
    func disableUpdateButton() {
        self.spyDisableUpdateButtonCalled = true
    }
    
    func showLoading() {
        self.spyShowLoadingCalled = true
    }
    
    func dismissLoading() {
        self.spyDismissLoadingCalled = true
    }
}
