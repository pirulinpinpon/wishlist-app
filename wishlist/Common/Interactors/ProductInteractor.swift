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
    func addProduct(_ product: Product, completionHandler: @escaping (Result<Bool, Error>) -> Void)
    func updateProduct(_ product: Product, completionHandler: @escaping (Result<Bool, Error>) -> Void)
    func removeProduct(_ product: Product, completionHandler: @escaping (Result<Bool, Error>) -> Void)
}

protocol ProductInteractorInput {
    func getProducts(completionHandler: @escaping (Result<ProductsData, Error>) -> Void)
    func addProduct(_ product: Product, completionHandler: @escaping (Result<Product, Error>) -> Void)
    func updateProduct(_ product: Product, completionHandler: @escaping (Result<Product, Error>) -> Void)
    func removeProduct(_ product: Product, completionHandler: @escaping (Result<Product, Error>) -> Void)
}

struct ProductInteractor: ProductInteractorProtocol {
    
    let dataInput: ProductInteractorInput
    
    func products(completionHandler: @escaping (Result<[Product], Error>) -> Void) {
        self.dataInput.getProducts { result in
            completionHandler(result.map(\.products))
        }
    }
    
    func addProduct(_ product: Product, completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        
    }
    
    func updateProduct(_ product: Product, completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        
    }
    
    func removeProduct(_ product: Product, completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        self.dataInput.removeProduct(product) { result in
            switch result {
            case .success:
                completionHandler(.success(true))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
