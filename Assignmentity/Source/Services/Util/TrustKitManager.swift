//
//  TrustKitManager.swift
//  Assignmentity
//
//  Created by Lucas Moreton on 07/04/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import Foundation
import TrustKit

struct TrustKitManager {
    
    /// Configure SSL Pinning on the project.
    static func start() {
        let trustKitConfig = [
            kTSKPinnedDomains: [
                "marlove.net": [
                    kTSKEnforcePinning: true,
                    kTSKIncludeSubdomains: true,
                    kTSKPublicKeyHashes: [
                        "MmU2NmM3Nzg3NGRmYjk1NmU4NmVkOTc2NjE5Njg0Y2U=",
                        "sHVL5DDw0J6Ec5UzAHcx8w7QY7IUtWFoRj9BUn+IF9k="
                    ]]
            ]]
        
        TrustKit.initSharedInstance(withConfiguration: trustKitConfig)
    }
    
    private init() { }
}
