//
//  StubModel.swift
//  wishlistTests
//
//  Created by Jerilyn Gonçalves on 30/08/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import UIKit
@testable import wishlist

struct StubModel {
    
    static let product = Product(
        id: "123ABC",
        createdAt: Date(),
        updatedAt: Date(),
        title: "Philips Hue White & Colour Ambiance Starter Kit",
        images: [
            "https://images-na.ssl-images-amazon.com/images/I/71CLO1n-iPL._AC_SL1500_.jpg"
        ],
        url: "https://www.amazon.co.uk/Philips-Ambiance-Wireless-Lighting-Starter/dp/B01K1WP7Z4",
        merchant: "Amazon"
    )
}
