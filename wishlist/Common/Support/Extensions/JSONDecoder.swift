//
//  JSONDecoder+Date.swift
//  wishlist
//
//  Created by Jerilyn Gonçalves on 29/08/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import Foundation

extension JSONDecoder {
    
    static func standard() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}
