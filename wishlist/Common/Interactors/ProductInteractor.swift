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
    func product(id: String, completionHandler: @escaping (Result<Product, Error>) -> Void)
    func addProduct(title: String, imageURL: String, merchant: String, merchantURL: String, completionHandler: @escaping (Result<Bool, Error>) -> Void)
    func updateProduct(_ product: Product, completionHandler: @escaping (Result<Bool, Error>) -> Void)
    func removeProduct(_ product: Product, completionHandler: @escaping (Result<Bool, Error>) -> Void)
}

protocol ProductInteractorInput {
    func getProducts(completionHandler: @escaping (Result<ProductsData, Error>) -> Void)
    func getProduct(id: String, completionHandler: @escaping (Result<ProductData, Error>) -> Void)
    func addProduct(title: String, imageURL: String, merchant: String, merchantURL: String, completionHandler: @escaping (Result<Product, Error>) -> Void)
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
    
    func addProduct(title: String, imageURL: String, merchant: String, merchantURL: String, completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        self.dataInput.addProduct(title: title, imageURL: imageURL, merchant: merchant, merchantURL: merchantURL) { result in
            switch result {
            case .success:
                completionHandler(.success(true))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func product(id: String, completionHandler: @escaping (Result<Product, Error>) -> Void) {
        self.dataInput.getProduct(id: id) { result in
            completionHandler(result.map(\.product))
        }
    }
    
    func updateProduct(_ product: Product, completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        self.dataInput.updateProduct(product) { result in
            switch result {
            case .success:
                completionHandler(.success(true))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
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
