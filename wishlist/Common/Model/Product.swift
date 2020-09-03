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
    let createdAt: Date
    let updatedAt: Date
    var title: String
    var images: [String]
    var url: String
    var merchant: String
}
