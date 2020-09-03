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
    func showProductDetail(_ product: Product)
    func dismissProductDetail()
    func showAddProduct()
    func dismissAddProduct()
    func showUpdateProduct(_ product: Product)
    func dismissUpdateProduct()
    func openURL(_ url: URL)
}

class ProductsWireframe {
    
    var navigationController: UINavigationController?
    
    // MARK: - Private method
    
    private func loadProductsVC() -> ProductsVC? {
        guard let productsVC = try? ProductsVC.instantiateFromStoryboard() else { return nil }
        productsVC.presenter = Builder.productsPresenter(view: productsVC, wireframe: self)
        return productsVC
    }
    
    private func loadProductDetailVC(product: Product) -> ProductDetailVC? {
        guard let productDetailVC = try? ProductDetailVC.instantiateFromStoryboard() else { return nil }
        productDetailVC.presenter = Builder.productDetailPresenter(view: productDetailVC, wireframe: self, product: product)
        return productDetailVC
    }
    
    private func loadUpdateProductVC(product: Product?) -> UpdateProductVC? {
        guard let updateProductVC = try? UpdateProductVC.instantiateFromStoryboard() else { return nil }
        updateProductVC.presenter = Builder.updateProductPresenter(view: updateProductVC, wireframe: self, product: product)
        return updateProductVC
    }
}

// MARK: - SplashWireframeProtocol

extension ProductsWireframe: ProductsWireframeProtocol {
    
    func showProducts(in navigationController: UINavigationController) {
        self.navigationController = navigationController        
        guard let productsVC = self.loadProductsVC() else { return }
        self.navigationController?.show(productsVC, sender: self)
    }
    
    func showProductDetail(_ product: Product) {
        guard let productDetailVC = self.loadProductDetailVC(product: product) else { return }
        self.navigationController?.show(productDetailVC, sender: self)
    }
    
    func dismissProductDetail() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func showAddProduct() {
        guard let addProductVC = self.loadUpdateProductVC(product: nil) else { return }
        self.navigationController?.show(addProductVC, sender: self)
    }
    
    func dismissAddProduct() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func showUpdateProduct(_ product: Product) {
        guard let updateProductVC = self.loadUpdateProductVC(product: product) else { return }
        self.navigationController?.show(updateProductVC, sender: self)
    }
    
    func dismissUpdateProduct() {
        self.navigationController?.popToRootViewController(animated: true)
    }

    func openURL(_ url: URL) {
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
}
