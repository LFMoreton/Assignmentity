//
//  UITableViewCell+Ext.swift
//  Assignmentity
//
//  Created by Lucas Moreton on 07/04/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    /// Cell's identifier
    static var identifier: String {
        return String(describing: self)
    }
}
