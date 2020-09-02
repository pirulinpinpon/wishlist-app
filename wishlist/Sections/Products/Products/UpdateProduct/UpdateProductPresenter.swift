//
//  UpdateProductPresenter.swift
//  wishlist
//
//  Created by Jerilyn Gonçalves on 30/08/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import Foundation

protocol UpdateProductUI: class {
    func loadProduct(_ product: Product?)
    func showLoading()
    func dismissLoading()
}

protocol UpdateProductPresenterProtocol {
    func onViewDidLoad()
    func userSelectedUpdateButton()
}


class UpdateProductPresenter {
    
    // MARK: - Public properties
    
    weak var view: UpdateProductUI?
    let wireframe: ProductsWireframeProtocol?
    let interactor: ProductInteractorProtocol?
    
    // MARK: - Private properties
    
    private var product: Product?

    // MARK: - Initializers

    init(view: UpdateProductUI, wireframe: ProductsWireframeProtocol, interactor: ProductInteractorProtocol, product: Product?) {
        self.view = view
        self.wireframe = wireframe
        self.interactor = interactor
        self.product = product
    }
    
    // MARK: - Private methods
    
    private func createProduct(_ product: Product) {
        self.interactor?.addProduct(product) { result in
            // ...
        }
    }
    
    private func updateProduct(_ product: Product) {
        self.interactor?.updateProduct(product) { result in
            // ...
        }
    }
}

// MARK: - UpdateProductPresenterProtocol

extension UpdateProductPresenter: UpdateProductPresenterProtocol {
    
    func onViewDidLoad() {
        self.view?.loadProduct(self.product)
    }
    
    func userSelectedUpdateButton() {
        
    }
}
