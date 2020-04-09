//
//  CatalogAPIProtocol.swift
//  Assignmentity
//
//  Created by Lucas Moreton on 07/04/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import Foundation

protocol CatalogAPIProtocol {
    func items(sinceID: String?, maxID: String?, completion: @escaping CompletionCallback)
    func removeAllItems(completion: @escaping CompletionCallback)
    func removeItem(withID id: String, completion: @escaping CompletionCallback)
    func addItem(json: [String: AnyObject], completion: @escaping CompletionCallback)
}
