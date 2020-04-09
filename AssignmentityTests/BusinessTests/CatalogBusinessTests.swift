//
//  CatalogBusinessTests.swift
//  AssignmentityTests
//
//  Created by Lucas Moreton on 08/04/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

@testable import Assignmentity
import XCTest

class CatalogBusinessTests: XCTestCase {

    private lazy var business: CatalogBusiness = {
        let provider = CatalogAPIProviderMock(jsonFile: file.rawValue)
        return CatalogBusiness(provider: provider)
    }()

    private lazy var file: CatalogAPIProviderMockFiles = {
        return .valid
    }()
}

extension CatalogBusinessTests {
    
    func testValidItemsRequest() {
        business.items { (result) in
            do {
                let items = try result()
                
                XCTAssert(items.count == 4)
                
                XCTAssertEqual(items.first?.identifier, "76fg7g978h9g79")
                XCTAssertEqual(items.first?.text, "abcd")
                XCTAssertEqual(items.first?.imageString, "R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==")
                XCTAssertEqual(items.first?.confidence, 0.68)
                
            } catch {
                XCTFail("Fail - Expected success on this test")
            }
        }
    }
    
    func testInvalidItemsRequest() {
        file = .invalid
        
        business.items { (result) in
            do {
                let _ = try result()
                
                XCTFail("Fail - Expected to fail here")
            } catch {
                XCTAssertNotNil(error)
            }
        }
    }
    
    func testEmptyItemsRequest() {
        file = .empty
        
        business.items { (result) in
            do {
                let items = try result()
                
                XCTAssertEqual(items.count, 0)
            } catch {
                XCTFail("Fail - Expected success on this test")
            }
        }
    }
    
    func testAddValidItemRequest() {
        file = .addValidItem
        let jsonDict = [
            "img" : "R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==",
            "confidence" : 0.68,
            "text" : "abcd" ] as [String : AnyObject]
        
        
        business.addItem(json: jsonDict) { (result) in
            do {
                let item = try result()
                
                XCTAssertEqual(item.identifier, "76fg7g978h9g79")
                XCTAssertEqual(item.text, "abcd")
                XCTAssertEqual(item.imageString, "R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==")
                XCTAssertEqual(item.confidence, 0.68)
                
            } catch {
                XCTFail("Fail - Expected success on this test")
            }
        }
    }
    
    func testRemoveAllItemsRequest() {
        file = .valid
        
        business.removeAllItems { (result) in
            do {
                let message = try result()
                
                XCTAssertEqual(message, "Sucessfully deleted all items from catalog.")
            } catch {
                XCTFail("Fail - Expected success on this test")
            }
        }
    }
    
    func testRemoveItemRequest() {
        file = .valid
        let identifier = "Batman"
        
        business.removeItem(withID: identifier) { (result) in
            do {
                let message = try result()
                
                XCTAssertEqual(message, "Sucessfully deleted item with id: \(identifier).")
            } catch {
                XCTFail("Fail - Expected success on this test")
            }
        }
    }
}
