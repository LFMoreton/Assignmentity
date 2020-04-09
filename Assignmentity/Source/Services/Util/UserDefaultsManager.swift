//
//  UserDefaultsManager.swift
//  Assignmentity
//
//  Created by Lucas Moreton on 08/04/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import Foundation

struct UserDefaultsManager {
    static func isFirstTime() -> Bool {
        return !UserDefaults.standard.bool(forKey: "is-first-time")
    }
    
    static func setFirstTime(_ value: Bool = true) {
        UserDefaults.standard.set(value, forKey: "is-first-time")
    }
    
    static func encryptionKey() -> Data {
        let key = "encryption-key"
        
        guard let data = UserDefaults.standard.data(forKey: key) else {
            // Generate a random encryption key
            var dataKey = Data(count: 64)
            
            _ = dataKey.withUnsafeMutableBytes { bytes in
                SecRandomCopyBytes(kSecRandomDefault, 64, bytes)
            }
            
            UserDefaults.standard.set(dataKey, forKey: key)
            
            return dataKey
        }
        
        return data
    }
}
