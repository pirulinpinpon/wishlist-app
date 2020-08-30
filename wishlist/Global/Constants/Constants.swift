//
//  Constants.swift
//  wishlist
//
//  Created by Jerilyn Gonçalves on 28/08/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Storyboards {
        static let products = "Products"
    }
    
    struct Views {
        static let products = "ProductsVC"
        static let productDetail = "ProductDetailVC"
    }
    
    struct CellIdentifier {
        static let product = "ProductCell"
    }
    
    struct Methods {
        static let get = "GET"
        static let post = "POST"
        static let delete = "DELETE"
        static let put = "PUT"
    }
    
    struct Texts {
        struct Products {
            static let title = "My wishlist"
            static let alertTitle = "Oh oh, something went wrong"
            static let alertMessage = "We weren't able to load you wishlist, please try again!"
            static let retryActionTile = "Try again"
        }
        struct ProductDetail {
            static let merchantTitle = "product sold by %s ⇢"
        }
    }
}
