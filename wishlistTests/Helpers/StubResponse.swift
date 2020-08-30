//
//  StubResponse.swift
//  wishlistTests
//
//  Created by Jerilyn Gonçalves on 30/08/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import Foundation
import OHHTTPStubs
import OHHTTPStubsSwift

@testable import wishlist

class StubResponse {
    
    class func mockSuccessResponse(for urlPath: String, with jsonFile: String) {
        _ = stub(condition: isPath(urlPath), response: { _ in
            return StubResponse.successResponse(with: jsonFile)
        })
    }
    
    class func mockFailureResponse(for urlPath: String, with jsonFile: String) {
        _ = stub(condition: isPath(urlPath), response: { _ in
            return StubResponse.failureResponse(with: jsonFile)
        })
    }
    
    class func successResponse(with json: String) -> HTTPStubsResponse {
        Self.stubResponse(with: json, code: 200)
    }
    
    class func failureResponse(with json: String) -> HTTPStubsResponse {
        Self.stubResponse(with: json, code: 400)
    }

    class func stubResponse(with json: String, code: Int) -> HTTPStubsResponse {
        return HTTPStubsResponse(
            fileAtPath: OHPathForFile(json, StubResponse.self)!,
            statusCode: Int32(code),
            headers: ["Content-Type": "application/json"]
        )
    }
}
