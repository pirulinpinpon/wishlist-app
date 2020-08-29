//
//  ProductsWireframe.swift
//  wishlist
//
//  Created by Jerilyn Gonçalves on 29/08/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import UIKit

protocol ProductsWireframeProtocol {
    func showProducts(in navigationController: UINavigationController)
}

class ProductsWireframe {
    
    var navigationController: UINavigationController?
    
    // MARK: - Private method
    
    private func loadProductsVC() -> ProductsVC? {
        guard let productsVC = try? ProductsVC.instantiateFromStoryboard() else { return nil }
        productsVC.presenter = Builder.productsPresenter(view: productsVC, wireframe: self)
        return productsVC
    }
}

// MARK: - SplashWireframeProtocol

extension ProductsWireframe: ProductsWireframeProtocol {
    
    func showProducts(in navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController?.isNavigationBarHidden = true
        
        guard let productsVC = self.loadProductsVC() else { return }
        self.navigationController?.show(productsVC, sender: self)
    }
}
