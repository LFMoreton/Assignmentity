//
//  UITableView+Ext.swift
//  Assignmentity
//
//  Created by Lucas Moreton on 07/04/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import UIKit

extension UITableView {
    
    /// Registers a class for use in creating new table cells.
    /// - Parameter anyClass: AnyClass
    func register(anyClass: AnyClass) {
        let identifier = String(describing: anyClass)
        register(anyClass, forCellReuseIdentifier: identifier)
    }
}
