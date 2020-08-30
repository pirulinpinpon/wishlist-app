//
//  Response.swift
//  wishlist
//
//  Created by Jerilyn Gonçalves on 29/08/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import Foundation


class Response {
	
    var statusCode: Int
    var url: URL?
    var headers: [AnyHashable: Any]?
    var body: Data?
    var error: Error?
	
	// MARK: - Initializers
	
	init() {
		self.statusCode = 0
	}
	
    convenience init(data: Data?, response: URLResponse?, error: Error?) {
        self.init()
		self.error = error
        guard let response = response as? HTTPURLResponse else { return }
        self.url = response.url
        self.headers = response.allHeaderFields
        self.body = data
        self.statusCode = response.statusCode
	}
    
    // MARK: - Public methods
    
    func handleResponse<ParseData: Decodable>(completionHandler: @escaping (Result<ParseData, Error>) -> Void) {
        if let error = self.error {
            completionHandler(.failure(error))
        } else if let body = self.body {
            do {
                let parsedData = try JSONDecoder.defaultDecoder().decode(ParseData.self, from: body)
                completionHandler(.success(parsedData))
            } catch let error {
                print(error.localizedDescription)
                completionHandler(.failure(error))
            }
        }
    }
}
