//
//  Item.swift
//  Assignmentity
//
//  Created by Lucas Moreton on 07/04/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object, Decodable {
    @objc dynamic var identifier: String = ""
    @objc dynamic var text: String = ""
    @objc dynamic var confidence: Double = 0
    @objc dynamic var imageString: String = ""
    
    enum CodingKeys: String, CodingKey {
        case text, confidence
        case identifier = "_id"
        case imageString = "img"
    }
    
    override class func primaryKey() -> String? {
        return "identifier"
    }
}
