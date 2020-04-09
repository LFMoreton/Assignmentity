//
//  ViewCodable.swift
//  Assignmentity
//
//  Created by Lucas Moreton on 07/04/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import Foundation

public protocol ViewCodable {
    func buildViewHierarchy()
    func setupConstraints()
    func additionalSetup()
    func setupView()
}

extension ViewCodable {
    public func setupView() {
        buildViewHierarchy()
        setupConstraints()
        additionalSetup()
    }
}
