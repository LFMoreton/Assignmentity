//
//  String+Ext.swift
//  Assignmentity
//
//  Created by Lucas Moreton on 07/04/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import UIKit

extension String {
    
    /// Creates UIImage from encoded string.
    /// - Returns: UIImage?
    func toImage() -> UIImage? {
        guard let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else {
            return nil
        }
        
        return UIImage(data: data)
    }
}
