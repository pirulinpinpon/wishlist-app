//
//  ProductService.swift
//  wishlist
//
//  Created by Jerilyn Gonçalves on 29/08/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import Foundation

struct ProductsData: Decodable {
    
    let products: [Product]
    
    enum CodingKeys: String, CodingKey {
        case products = "posts"
    }
}

struct ProductData: Decodable {
    
    let product: Product
    
    enum CodingKeys: String, CodingKey {
        case product = "post"
    }
}

struct ProductServiceKeys {
    static let id = "id"
    static let title = "title"
    static let images = "images"
    static let merchantURL = "url"
    static let merchant = "merchant"
}

struct ProductService: ProductInteractorInput {
    
    func getProducts(completionHandler: @escaping (Result<ProductsData, Error>) -> Void) {
        
        let request = Request(
            method: HTTPMethod.post.rawValue,
            baseURL: Config.host,
            endpoint: Endpoints.Products.products,
            verbose: true
        )
        request.fetch { response in
            response.handleResponse(completionHandler: completionHandler)
        }
    }
    
    func getProduct(id: String, completionHandler: @escaping (Result<ProductData, Error>) -> Void) {
        let request = Request(
            method: HTTPMethod.get.rawValue,
            baseURL: Config.host,
            endpoint: Endpoints.Products.product + id,
            verbose: true
        )
        request.fetch { response in
            response.handleResponse(completionHandler: completionHandler)
        }
    }
    func addProduct(title: String, imageURL: String, merchant: String, merchantURL: String, completionHandler: @escaping (Result<Product, Error>) -> Void) {
        let request = Request(
            method: HTTPMethod.post.rawValue,
            baseURL: Config.host,
            endpoint: Endpoints.Products.create,
            bodyParams: [
                ProductServiceKeys.title: title,
                ProductServiceKeys.images: [
                    imageURL
                ],
                ProductServiceKeys.merchantURL: merchantURL,
                ProductServiceKeys.merchant: merchant
            ],
            verbose: true
        )
        request.fetch { response in
            response.handleResponse(completionHandler: completionHandler)
        }
    }
    
    func updateProduct(_ product: Product, completionHandler: @escaping (Result<Product, Error>) -> Void) {
        let request = Request(
            method: HTTPMethod.post.rawValue,
            baseURL: Config.host,
            endpoint: Endpoints.Products.update,
            bodyParams: [
                ProductServiceKeys.id: product.id,
                ProductServiceKeys.title: product.title,
                ProductServiceKeys.images: [
                    product.images.first ?? ""
                ],
                ProductServiceKeys.merchantURL: product.url,
                ProductServiceKeys.merchant: product.merchant
            ],
            verbose: true
        )
        request.fetch { response in
            response.handleResponse(completionHandler: completionHandler)
        }
    }
    
    func removeProduct(_ product: Product, completionHandler: @escaping (Result<Product, Error>) -> Void) {
        let request = Request(
            method: HTTPMethod.post.rawValue,
            baseURL: Config.host,
            endpoint: Endpoints.Products.delete,
            bodyParams: [
                ProductServiceKeys.id: product.id
            ],
            verbose: true
        )
        request.fetch { response in
            response.handleResponse(completionHandler: completionHandler)
        }
    }
}
