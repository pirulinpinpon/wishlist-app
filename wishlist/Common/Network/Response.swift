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
    var error: NSError?
	
	// MARK: - Initializers
	
	init() {
		self.statusCode = 0
	}
	
    convenience init(data: Data?, response: URLResponse?, error: Error?) {
        self.init()
		self.error = error as NSError?
        guard let response = response as? HTTPURLResponse else { return }
        self.url = response.url
        self.headers = response.allHeaderFields
        self.body = data
        self.statusCode = response.statusCode
	}
    
    // MARK: - Public methods
    
    func handleResponse<ParseData: Decodable>(completionHandler: @escaping (Result<ParseData, NSError>) -> Void) {
        if let error = self.error {
            completionHandler(.failure(error))
        } else if let body = self.body, let parsedData = try? JSONDecoder.standard().decode(ParseData.self, from: body) {
            completionHandler(.success(parsedData))
        } else {
            completionHandler(.failure(NSError()))
        }
    }
}
