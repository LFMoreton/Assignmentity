//
//  StringExtensionTests.swift
//  AssignmentityTests
//
//  Created by Lucas Moreton on 08/04/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

@testable import Assignmentity
import XCTest

class StringExtensionTests: XCTestCase {
    
    func testValidBase64String() {
        let base64String = "R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="
        
        XCTAssertNotNil(base64String.toImage())
    }
    
    func testInvalidBase64String() {
        let nintendo64String = "Nintendo 64!!!"
        
        XCTAssertNil(nintendo64String.toImage())
    }
}
