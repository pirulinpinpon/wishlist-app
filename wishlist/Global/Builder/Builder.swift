//
//  Builder.swift
//  wishlist
//
//  Created by Jerilyn Gonçalves on 28/08/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import Foundation

protocol BuilderProtocol {
    
    static func productsPresenter(view: ProductsUI, wireframe: ProductsWireframeProtocol) -> ProductsPresenter

}

struct Builder: BuilderProtocol {
    
    static func productsPresenter(view: ProductsUI, wireframe: ProductsWireframeProtocol) -> ProductsPresenter {
        return ProductsPresenter(
            view: view,
            wireframe: wireframe,
            interactor: self.productInteractor()
        )
    }
    
    // MARK: - Interactors
    
    static func productInteractor() -> ProductInteractorProtocol {
        return ProductInteractor(dataInput: ProductService())
    }
}
