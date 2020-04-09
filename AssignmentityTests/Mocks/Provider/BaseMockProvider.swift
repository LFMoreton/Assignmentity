//
//  BaseMockProvider.swift
//  AssignmentityTests
//
//  Created by Lucas Moreton on 08/04/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

@testable import Assignmentity
import Foundation

class BaseMockProvider {

    // MARK: - Private properties

    private var readData: Bool
    private var jsonFile: String

    // MARK: - Initializers

    init(jsonFile: String = "") {
        self.jsonFile = jsonFile
        readData = jsonFile != ""
    }

    // MARK: - Public methods

    func loadResponse() -> Result<Data, Error> {
        if let path = Bundle(for: type(of: self)).path(forResource: jsonFile, ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                return .success(data)
            }
        }

        return .failure(NSError())
    }
}
