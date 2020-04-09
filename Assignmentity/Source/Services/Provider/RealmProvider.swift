//
//  RealmProvider.swift
//  Assignmentity
//
//  Created by Lucas Moreton on 08/04/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import RealmSwift

class RealmProvider {
    class func save(item: Item) throws {
        let realm = try RealmProvider.encryptedRealm()
        DispatchQueue.main.async {
            try? realm.write {
                let savedItems = realm.objects(Item.self)
                
                if !savedItems.contains(item) {
                    realm.add(item)
                }
            }
        }
    }
    
    class func save(items: [Item]) throws {
        let realm = try RealmProvider.encryptedRealm()
        DispatchQueue.main.async {
            try? realm.write {
                let savedItems = realm.objects(Item.self)
                
                let validItems = items.filter { !savedItems.contains($0) }
                realm.add(validItems)
            }
        }
    }
    
    class func deleteItem(withID identifier: String) throws {
        let realm = try RealmProvider.encryptedRealm()
        
        guard let item = realm.object(ofType: Item.self, forPrimaryKey: identifier) else { return }
        try realm.write {
            realm.delete(item)
        }
    }
    
    class func deleteAllItems() throws {
        let realm = try RealmProvider.encryptedRealm()
        
        let items = realm.objects(Item.self)
        
        try realm.write {
            realm.delete(items)
        }
    }
    
    class func getItems(afterItem: Item? = nil) throws -> [Item] {
        let realm = try RealmProvider.encryptedRealm()
        
        let numberOfItems = 10
        
        let items = realm.objects(Item.self)
        
        if let item = afterItem {
            guard let itemIndex = items.firstIndex(where: { $0.identifier == item.identifier } ),
                itemIndex < items.count - 1 else {
                return [Item]()
            }
            
            let nextIndex = (itemIndex + 1) + numberOfItems
            
            if items.count >= nextIndex {
                return [Item](items[itemIndex..<nextIndex])
            } else {
                return [Item](items[itemIndex...])
            }
            
        } else {
            let initialIndex = 0
            if items.count >= numberOfItems {
                return [Item](items[initialIndex..<numberOfItems])
            } else {
                return [Item](items[initialIndex...])
            }
        }
    }
    
    static func encryptedRealm() throws -> Realm {
        let key = UserDefaultsManager.encryptionKey()
        
        // Open the encrypted Realm file
        let config = Realm.Configuration(encryptionKey: key)
        do {
            let realm = try Realm(configuration: config)
            
            return realm
        } catch let error as NSError {
            // If the encryption key is wrong, `error` will say that it's an invalid database
            fatalError("Error opening realm: \(error)")
        }
    }
}
