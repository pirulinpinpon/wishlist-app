//
//  ProductDetailPresenter.swift
//  wishlist
//
//  Created by Jerilyn Gonçalves on 30/08/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import Foundation

protocol ProductDetailUI: class {
    func loadProduct(_ product: Product)
}

protocol ProductDetailPresenterProtocol {
    func onViewDidLoad()
    func userSelectedRemoveProduct()
    func userSelectedMerchantWebsite()
}


class ProductDetailPresenter {
    
    // MARK: - Public properties
    
    weak var view: ProductDetailUI?
    let wireframe: ProductsWireframeProtocol?
    let interactor: ProductInteractorProtocol?
    
    // MARK: - Private properties
    
    private var product: Product?

    // MARK: - Initializers

    init(view: ProductDetailUI, wireframe: ProductsWireframeProtocol, interactor: ProductInteractorProtocol, product: Product) {
        self.view = view
        self.wireframe = wireframe
        self.interactor = interactor
        self.product = product
    }
    
    // MARK: - Private methods
    
    // ...
}

// MARK: - ProductDetailPresenterProtocol

extension ProductDetailPresenter: ProductDetailPresenterProtocol {
    
    func onViewDidLoad() {
        guard let product = self.product else { return }
        self.view?.loadProduct(product)
    }
    
    func userSelectedMerchantWebsite() {
        guard let merchantWebsite = self.product?.url, let merchantWebsiteURL = URL(string: merchantWebsite) else { return }
        self.wireframe?.openURL(merchantWebsiteURL)
    }
    
    func userSelectedRemoveProduct() {
        // TODO: Should show alert to confirm action
    }
}
