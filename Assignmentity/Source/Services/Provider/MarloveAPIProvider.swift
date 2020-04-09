//
//  MarloveAPIProvider.swift
//  Assignmentity
//
//  Created by Lucas Moreton on 07/04/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import Foundation

class MarloveAPIProvider {
    
    //MARK: - Constants
    
    private let kTimeout = 10
    
    //MARK: - Properties
    
    let sessionManager: URLSession
    let scheme = "https"
    let host = "marlove.net"
    let path = "/e/mock/v1"
    
    private let baseHeaders = [
        "Authorization" : "07fd7f39543047d4d5b49f0599b5e3e3",
        "ContentType" : "application/json"
    ]
    
    //MARK: - Singleton
    
    static let shared = MarloveAPIProvider()
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(kTimeout)
        configuration.timeoutIntervalForResource = TimeInterval(kTimeout)
        configuration.httpAdditionalHeaders = baseHeaders
        
        sessionManager = URLSession(configuration: configuration)
    }
}
