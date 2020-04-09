//
//  ItemsViewModel.swift
//  Assignmentity
//
//  Created by Lucas Moreton on 07/04/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import UIKit

class ItemsViewModel: ViewModelProtocol {
    
    private weak var view: ViewModelDelegate?
    private var items: [Item] = []
    
    init(view: ViewModelDelegate, items: [Item]) {
        self.view = view
        self.items = items
    }
    
    private func registerCell() {
        view?.registerCell(anyClass: ItemCell.self)
    }
    
    func didSetViewModel() {
        registerCell()
    }
    
    var numberOfSection: Int {
        return 1
    }
    
    func numberOfElements(in section: Int) -> Int {
        items.count
    }
    
    func cellIdentifier(at indexPath: IndexPath) -> String {
        return ItemCell.identifier
    }
    
    func element(at indexPath: IndexPath) -> Any {
        return items[indexPath.row]
    }
}
