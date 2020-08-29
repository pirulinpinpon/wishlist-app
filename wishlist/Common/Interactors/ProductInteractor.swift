//
//  ProductInteractor.swift
//  wishlist
//
//  Created by Jerilyn Gonçalves on 29/08/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import Foundation

protocol ProductInteractorProtocol {
    func products(completionHandler: @escaping (Result<[Product], Error>) -> Void)
}

protocol ProductInteractorInput {
    func getProducts(completionHandler: @escaping (Result<ProductsData, Error>) -> Void)
}

struct ProductInteractor: ProductInteractorProtocol {
    
    let dataInput: ProductInteractorInput
    
    func products(completionHandler: @escaping (Result<[Product], Error>) -> Void) {
        self.dataInput.getProducts { result in
            completionHandler(result.map(\.products))
        }
    }
}
