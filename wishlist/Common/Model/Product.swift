//
//  Product.swift
//  wishlist
//
//  Created by Jerilyn Gonçalves on 29/08/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import Foundation

struct Product: Decodable, Identifiable {
    
    let id: String
    let createdAt: String
    let updatedAt: String
    let title: String
    let images: [String]
    let url: String
    let merchant: String
}
