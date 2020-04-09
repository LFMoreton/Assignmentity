//
//  CatalogAPIProviderMock.swift
//  AssignmentityTests
//
//  Created by Lucas Moreton on 08/04/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

@testable import Assignmentity
import Foundation

enum CatalogAPIProviderMockFiles: String {
    case valid
    case invalid
    case empty
    case addValidItem
}

class CatalogAPIProviderMock: BaseMockProvider, CatalogAPIProtocol {
    func items(sinceID: String?, maxID: String?, completion: @escaping CompletionCallback) {
        completion(loadResponse())
    }
    
    func removeAllItems(completion: @escaping CompletionCallback) {
        completion(loadResponse())
    }
    
    func removeItem(withID id: String, completion: @escaping CompletionCallback) {
        completion(loadResponse())
    }
    
    func addItem(json: [String : AnyObject], completion: @escaping CompletionCallback) {
        completion(loadResponse())
    }
}
