//
//  Request.swift
//  wishlist
//
//  Created by Jerilyn Gonçalves on 29/08/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import Foundation


enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

class Request {
	
    // MARK: - Properties
    
    var method: String
    var baseURL: String
    var endpoint: String
    var headers: [String: String]?
    var urlParams: [String: Any]?
    var bodyParams: [String: Any]?
    var verbose = false
    var timeout: TimeInterval
	
    var request: URLRequest?
    weak var task: URLSessionTask?
    
    // MARK: - Initializer
    
    init(method: String, baseURL: String, endpoint: String, headers: [String: String]? = nil, urlParams: [String: Any]? = nil, bodyParams: [String: Any]? = nil, timeout: TimeInterval? = nil, verbose: Bool = false) {
        self.method = method
        self.baseURL = baseURL
        self.endpoint = endpoint
        self.headers = headers
        self.urlParams = urlParams
        self.bodyParams = bodyParams
        self.timeout = timeout ?? 15.0
        self.verbose = verbose
    }
    
    // MARK: - Public methods

    func fetch(completionHandler: @escaping (Response) -> Void) {
		guard let request = self.buildRequest() else { return }
		self.request = request
		self.cancel()
        if self.verbose { RequestLogger.logRequest(self) }
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = self.timeout
        configuration.waitsForConnectivity = true
        let session = URLSession(configuration: configuration, delegate: self as? URLSessionDelegate, delegateQueue: nil)
        
		self.task = session.dataTask(with: request) { data, urlResponse, error in
            defer {
                session.finishTasksAndInvalidate()
            }
            let response = Response(data: data, response: urlResponse, error: error)
			if self.verbose { RequestLogger.logResponse(response) }
			
			DispatchQueue.main.async {
				completionHandler(response)
			}
		}
		
		self.task?.resume()
	}
	
    func cancel() {
		self.task?.cancel()
	}
	
	// MARK: - Private helpers
    
	private func buildRequest() -> URLRequest? {
        var finalURL: URL?
        if let urlString = self.buildURL() {
            finalURL = self.addParams(to: URLComponents(string: urlString))
        }
        guard let url = finalURL else {  return nil }

		var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: self.timeout)
		request.httpMethod = self.method
		request.allHTTPHeaderFields = self.headers
		
        guard self.method != HTTPMethod.get.rawValue else { return request }
        if let bodyParams = self.bodyParams {
            let jsonData = try? JSONSerialization.data(withJSONObject: bodyParams)
            request.httpBody = jsonData
        }
			
        guard let containsContentType = request.allHTTPHeaderFields?.keys.contains("Content-Type"), !containsContentType else { return request }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
		return request
	}
	
    private func addParams(to urlComponents: URLComponents?) -> URL? {
        guard var urlComponents = urlComponents else { return nil }
        
        if let urlParams = self.urlParams?.map({ URLQueryItem(name: $0, value: String(describing: $1)) }) {
            let urlConcat = concat(urlComponents.queryItems, urlParams)
            urlComponents.queryItems = urlConcat
        }
        guard let string = urlComponents.string else { return nil }
        
        return URL(string: string)
    }
    
    private func buildURL() -> String? {
        var url = URLComponents(string: self.baseURL)
        url?.path += self.endpoint
        
        return url?.string
    }
    
    private func concat(_ lhs: [URLQueryItem]?, _ rhs: [URLQueryItem]?) -> [URLQueryItem] {
        guard let left = lhs else { return rhs ?? [] }
        guard let right = rhs else { return left }
        
        return left + right
    }
}
