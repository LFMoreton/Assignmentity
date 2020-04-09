//
//  UIViewExtensionTests.swift
//  AssignmentityTests
//
//  Created by Lucas Moreton on 08/04/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

@testable import Assignmentity
import XCTest

class UIViewExtensionTests: XCTestCase {
    
    func testBindFrameToSuperview() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        let stackView = UIStackView()
        
        view.addSubview(stackView)
        
        XCTAssertNotEqual(stackView.bounds, view.bounds)
        
        stackView.bindFrameToSuperviewBounds()
        stackView.layoutIfNeeded()
        
        XCTAssertEqual(stackView.bounds, view.bounds)
    }
    
    func testBindFrameWithoutSuperview() {
        let stackView = UIStackView()
        
        XCTAssertEqual(stackView.translatesAutoresizingMaskIntoConstraints, true)
        
        stackView.bindFrameToSuperviewBounds()
        
        XCTAssertNotEqual(stackView.translatesAutoresizingMaskIntoConstraints, false)
    }
}
