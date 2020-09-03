//
//  Endpoints.swift
//  wishlist
//
//  Created by Jerilyn Gonçalves on 28/08/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import Foundation

struct Endpoints {
    
    struct Products {
        static let products = "/products"
        static let offset = "/products/offset"
        static let cursor = "/products/cursor"
        static let product = "/product/"
        static let create = "/product/create"
        static let update = "/product/update"
        static let delete = "/product/delete"
    }
}
