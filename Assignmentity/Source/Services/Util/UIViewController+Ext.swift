//
//  UIViewController+Ext.swift
//  Assignmentity
//
//  Created by Lucas Moreton on 07/04/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// Presents an error on the user interface.
    /// - Parameters:
    ///   - title: Alert title.
    ///   - message: Alert message.
    ///   - actions: Alert actions.
    func presentError(withTitle title: String,
                      message: String,
                      actions: [UIAlertAction] = [UIAlertAction(title: "OK", style: .default)]) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        actions.forEach { action in
            alertController.addAction(action)
        }
        present(alertController, animated: true)
    }
}
