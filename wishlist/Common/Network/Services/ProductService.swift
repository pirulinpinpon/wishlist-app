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
}
