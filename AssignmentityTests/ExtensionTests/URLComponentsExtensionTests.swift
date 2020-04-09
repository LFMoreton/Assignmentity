//
//  URLComponentsExtensionTests.swift
//  AssignmentityTests
//
//  Created by Lucas Moreton on 08/04/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

@testable import Assignmentity
import XCTest

class URLComponentsExtensionTests: XCTestCase {

    func testSetQueryParams() {
        var urlComponents = URLComponents()
        let queryParams: [String: String?] = [
            "since_id" : "1234",
            "max_id" : nil
        ]
        
        urlComponents.setQueryItems(with: queryParams)
        
        XCTAssertEqual(urlComponents.queryItems?.count, 1)
    }
}
