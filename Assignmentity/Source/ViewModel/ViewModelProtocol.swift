//
//  ViewModelProtocol.swift
//  Assignmentity
//
//  Created by Lucas Moreton on 07/04/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import UIKit

protocol ViewModelProtocol: class {
    var numberOfSection: Int { get }

    func didSetViewModel()

    func numberOfElements(in section: Int) -> Int

    func cellIdentifier(at indexPath: IndexPath) -> String
    func element(at indexPath: IndexPath) -> Any
}

protocol ViewModelDelegate: class {
    func reloadData()
    func registerCell(anyClass: AnyClass)
}

protocol Fillable {
    func fill(data: Any)
}
