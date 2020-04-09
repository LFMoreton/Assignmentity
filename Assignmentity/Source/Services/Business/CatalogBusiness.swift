//
//  CatalogBusiness.swift
//  Assignmentity
//
//  Created by Lucas Moreton on 07/04/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import Foundation

// MARK: - Typealias

typealias ItemsCallback = (@escaping () throws -> [Item]) -> Void
typealias AddedItemCallback = (@escaping () throws -> Item) -> Void
typealias RemoveItemCallback = (@escaping () throws -> String) -> Void

// MARK: - Enum

class CatalogBusiness {

    // MARK: - Properties

    private var provider: CatalogAPIProtocol

    // MARK: - Initializers

    init(provider: CatalogAPIProtocol = CatalogAPIProvider()) {
        self.provider = provider
    }

    // MARK: - Methods
    
    func items(sinceID: String? = nil, maxID: String? = nil, completion: @escaping ItemsCallback) {
        provider.items(sinceID: sinceID, maxID: maxID) { [weak self] result in
            switch result {
            case .success(let data):
                self?.handleSuccess(data: data, completion: completion)
            case .failure(let error):
                self?.handleError(error: error, completion: completion)
            }
        }
    }
    
    func addItem(json: [String: AnyObject], completion: @escaping AddedItemCallback) {
        provider.addItem(json: json) { [weak self] result in
            switch result {
            case .success(let data):
                self?.handleAddItemSuccess(data: data, completion: completion)
            case .failure(let error):
                completion { throw error }
            }
        }
    }
    
    func removeItem(withID id: String, completion: @escaping RemoveItemCallback) {
        provider.removeItem(withID: id) { result in
            switch result {
            case .success(_):
                completion { "Sucessfully deleted item with id: \(id)." }
            case .failure(let error):
                completion { throw error }
            }
        }
    }
    
    func removeAllItems(completion: @escaping RemoveItemCallback) {
        provider.removeAllItems { result in
            switch result {
            case .success(_):
                completion { "Sucessfully deleted all items from catalog." }
            case .failure(let error):
                completion { throw error }
            }
        }
    }
    
    private func handleAddItemSuccess(data: Data, completion: @escaping AddedItemCallback) {
        guard let newItem = try? JSONDecoder().decode(Item.self, from: data) else {
            completion { throw CustomError.parse("Could not parse list of Items.") }
            return
        }
        
        completion { newItem }
    }
    
    private func handleSuccess(data: Data, completion: @escaping ItemsCallback) {
        guard let items = try? JSONDecoder().decode([Item].self, from: data) else {
            completion { throw CustomError.parse("Could not parse list of Items.") }
            return
        }
        
        completion { items }
    }
    
    private func handleError(error: Error, completion: @escaping ItemsCallback) {
        completion { throw error }
    }
}
