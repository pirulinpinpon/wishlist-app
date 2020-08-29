//
//  RequestLogger.swift
//  wishlist
//
//  Created by Jerilyn Gonçalves on 29/08/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import Foundation

struct RequestLogger {
    
    // MARK: - Request
    
    static func logRequest(_ request: Request) {
        guard request.verbose else { return }
        
        let url = request.request?.url?.absoluteString ?? "No URL set"
        let method = request.request?.httpMethod ?? "No HTTP method set"
        
        var log = "\n⇢ ⇢ ⇢ ⇢ ⇢\nREQUEST ✉️\n"
        log += " - URL:\t\t\(url)\n"
        log += " - METHOD:\t\(method)\n"
        let body = self.logBody(request)
        let headers = self.logHeaders(request)
        log += body + headers + "⇢ ⇢ ⇢ ⇢ ⇢\n"
        
        print(log)
    }
    
    // MARK: - Response
    
    static func logResponse(_ response: Response) {
        var log = "\n⇠ ⇠ ⇠ ⇠ ⇠\nRESPONSE 📨\n"
        log += " - URL:\t" + self.logURL(response) + "\n"
        log += " - CODE:\t" + "\(response.statusCode)\n"
        let headers = self.logHeaders(response)
        let data = self.logData(response)
        log += headers + data + "⇠ ⇠ ⇠ ⇠ ⇠\n"
        print(log)
    }
        
    // MARK: - Private helpers

    private static func logBody(_ request: Request) -> String {
        guard let body = request.request?.httpBody, let json = String(data: body, encoding: String.Encoding.utf8) else { return "" }
        return " - BODY:\n\(json)\n"
    }
    
    private static func logHeaders(_ request: Request) -> String {
        guard let headers = request.request?.allHTTPHeaderFields, !headers.isEmpty else { return "" }
        var log = " - HEADERS: {"
        headers.keys.forEach {
            if let value = headers[$0] {
                log += "\n\t\t\($0): \(value)"
            }
        }
        return log + "\n}\n"
    }
    
    private static func logURL(_ response: Response) -> String {
        guard let url = response.url?.absoluteString else { return "No URL" }
        return url
    }
    
    private static func logHeaders(_ response: Response) -> String {
        guard let headers = response.headers else { return "" }
        var log = " - HEADERS: {"
        headers.keys.forEach {
            if let value = headers[$0] {
                log += "\n\t\t\($0): \(value)"
            }
        }
        return log + "\n}\n"
    }
    
    private static func logData(_ response: Response) -> String {
        guard let body = response.body else { return "" }
        if let json = String(data: body, encoding: String.Encoding.utf8) {
            return " - JSON:\n\(json)\n"
        } else if let string = String(data: body, encoding: .utf8) {
            return" - DATA:\n\(string)\n"
        } else {
            return ""
        }
    }
}
