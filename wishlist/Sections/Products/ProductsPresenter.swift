//
//  ProductsPresenter.swift
//  wishlist
//
//  Created by Jerilyn Gonçalves on 29/08/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import Foundation

protocol ProductsUI: class {
    func showInitialLoader()
    func dismissInitialLoader()
    func showProducts()
    func showAlert(title: String, message: String)
}

protocol ProductsPresenterProtocol {
    func onViewDidLoad()
    func userSelectedRetry()
    func numberOfProducts() -> Int
    func product(at index: Int) -> Product?
    func userSelectedProduct(at index: Int)
}


class ProductsPresenter {
    
    // MARK: - Public properties
    
    weak var view: ProductsUI?
    let wireframe: ProductsWireframeProtocol?
    let interactor: ProductInteractorProtocol?
    
    // MARK: - Private properties
    
    private var products: [Product] = []

    // MARK: - Initializers

    init(view: ProductsUI, wireframe: ProductsWireframeProtocol, interactor: ProductInteractorProtocol) {
        self.view = view
        self.wireframe = wireframe
        self.interactor = interactor
    }
    
    // MARK: - Private methods
    
    private func loadProducs() {
        self.view?.showInitialLoader()
        self.interactor?.products { result in
            self.view?.dismissInitialLoader()
            switch result {
            case .success(let products):
                self.products = products
                self.view?.showProducts()
            case .failure:
                self.view?.showAlert(
                    title: "Oh oh, something went wrong",
                    message: "We weren't able to load you wishlist, please try again!"
                )
            }
        }
    }
}

// MARK: - SplashPresenterProtocol

extension ProductsPresenter: ProductsPresenterProtocol {
    
    func onViewDidLoad() {
        self.loadProducs()
    }
    
    func userSelectedRetry() {
        self.loadProducs()
    }
    
    func numberOfProducts() -> Int {
        return self.products.count
    }
    
    func product(at index: Int) -> Product? {
        guard self.products.count > index else { return nil }
        return self.products[index]
    }
    
    func userSelectedProduct(at index: Int) {
        // TODO: Should show detail view for selected product
    }
}
