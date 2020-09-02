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
    static func productDetailPresenter(view: ProductDetailUI, wireframe: ProductsWireframeProtocol, product: Product) -> ProductDetailPresenter
    static func updateProductPresenter(view: UpdateProductUI, wireframe: ProductsWireframeProtocol, product: Product?) -> UpdateProductPresenter
}

struct Builder: BuilderProtocol {
    
    static func productsPresenter(view: ProductsUI, wireframe: ProductsWireframeProtocol) -> ProductsPresenter {
        return ProductsPresenter(
            view: view,
            wireframe: wireframe,
            interactor: self.productInteractor()
        )
    }
    
    static func productDetailPresenter(view: ProductDetailUI, wireframe: ProductsWireframeProtocol, product: Product) -> ProductDetailPresenter {
        return ProductDetailPresenter(
            view: view,
            wireframe: wireframe,
            interactor: self.productInteractor(),
            product: product
        )
    }
    
    static func updateProductPresenter(view: UpdateProductUI, wireframe: ProductsWireframeProtocol, product: Product?) -> UpdateProductPresenter {
        return UpdateProductPresenter(
            view: view, wireframe:
            wireframe,
            interactor: self.productInteractor(),
            product: product
        )
    }
    
    // MARK: - Interactors
    
    static func productInteractor() -> ProductInteractorProtocol {
        return ProductInteractor(dataInput: ProductService())
    }
}
