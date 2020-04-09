//
//  CatalogManager.swift
//  Assignmentity
//
//  Created by Lucas Moreton on 07/04/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import Foundation

// MARK: - Typealias

typealias ItemsResultCallback = ([Item], Error?) -> Void
typealias AddedItemResultCallback = (Item?, Error?) -> Void
typealias RemoveItemResultCallback = (String?, Error?) -> Void

class CatalogManager: BaseManager {

    // MARK: - Private properties

    private var business: CatalogBusiness

    // MARK: - Initializers

    init(business: CatalogBusiness = CatalogBusiness()) {
        self.business = business
    }

    // MARK: - Public methods
    
    func items(sinceID: String? = nil, maxID: String? = nil, completion: @escaping ItemsResultCallback) {
        addOperation {
            self.business.items(sinceID: sinceID, maxID: maxID) { result in
                do {
                    let items = try result()
                    
                    DispatchQueue.main.async {
                        completion(items, nil)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion([], error)
                    }
                }
            }
        }
    }
    
    func addItem(json: [String: AnyObject], completion: @escaping AddedItemResultCallback) {
        addOperation {
            self.business.addItem(json: json) { result in
                do {
                    let newItem = try result()
                    
                    DispatchQueue.main.async {
                        completion(newItem, nil)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
    }
    
    func removeItem(withID id: String, completion: @escaping RemoveItemResultCallback) {
        addOperation {
            self.business.removeItem(withID: id) { result in
                do {
                    let message = try result()
                    
                    DispatchQueue.main.async {
                        completion(message, nil)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
    }
    
    func removeAllItems(completion: @escaping RemoveItemResultCallback) {
        addOperation {
            self.business.removeAllItems { result in
                do {
                    let message = try result()
                    
                    DispatchQueue.main.async {
                        completion(message, nil)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
    }
}
