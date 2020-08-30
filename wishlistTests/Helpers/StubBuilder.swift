//
//  TestBuilder.swift
//  wishlistTests
//
//  Created by Jerilyn Gonçalves on 30/08/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import Foundation
@testable import wishlist

struct StubBuilder: BuilderProtocol {
    
    static func productsPresenter(view: ProductsUI, wireframe: ProductsWireframeProtocol) -> ProductsPresenter {
        ProductsPresenter(
            view: view,
            wireframe: wireframe,
            interactor: ProductInteractor(dataInput: ProductService())
        )
    }
    
    static func productDetailPresenter(view: ProductDetailUI, wireframe: ProductsWireframeProtocol, product: Product) -> ProductDetailPresenter {
        ProductDetailPresenter(
            view: view,
            wireframe: wireframe,
            interactor: ProductInteractor(dataInput: ProductService()),
            product: product
        )
    }
}
