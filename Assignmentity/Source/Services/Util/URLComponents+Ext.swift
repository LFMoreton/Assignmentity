//
//  URLComponents+Ext.swift
//  Assignmentity
//
//  Created by Lucas Moreton on 07/04/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import Foundation

extension URLComponents {
    
    /// Set parameters to `queryItems`.
    /// - Parameter parameters: [String: String?]
    mutating func setQueryItems(with parameters: [String: String?]) {
        let validParameters = parameters.filter { $0.value != nil }
        self.queryItems = validParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
