//
//  ProductsPresenter.swift
//  wishlist
//
//  Created by Jerilyn Gonçalves on 29/08/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import Foundation

protocol ProductsUI: class {
    
}

protocol ProductsPresenterProtocol {
    func onViewDidLoad()
}


class ProductsPresenter {
    
    // MARK: Public properties
    
    weak var view: ProductsUI?
    let wireframe: ProductsWireframeProtocol?
    let interactor: ProductInteractorProtocol?

    // MARK: - Initializers

    init(view: ProductsUI, wireframe: ProductsWireframeProtocol, interactor: ProductInteractorProtocol) {
        self.view = view
        self.wireframe = wireframe
        self.interactor = interactor
    }
}

// MARK: - SplashPresenterProtocol

extension ProductsPresenter: ProductsPresenterProtocol {
    
    func onViewDidLoad() {
        // ...
    }
}
