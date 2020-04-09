//
//  UIImage+Ext.swift
//  Assignmentity
//
//  Created by Lucas Moreton on 09/04/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import UIKit
import CoreGraphics

extension UIImage {
    func toBase64String() -> String? {
        guard let data = pngData() else { return nil }
        
        return data.base64EncodedString(options: .lineLength64Characters)
    }
    
    class func resize(image: UIImage?, to size: CGFloat) -> UIImage? {
        guard let image = image else { return nil }
        let rect = CGRect(x: 0, y: 0, width: size, height: size)
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: size, height: size), false, 1.0)
        image.draw(in: rect)
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
}
