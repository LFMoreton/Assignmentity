//
//  CustomError.swift
//  Assignmentity
//
//  Created by Lucas Moreton on 07/04/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import Foundation


/// Custom errors enum.
enum CustomError: Error {
    case server(String)
    case parse(String)
    case generic
}
