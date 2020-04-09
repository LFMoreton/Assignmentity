//
//  BaseManager.swift
//  Assignmentity
//
//  Created by Lucas Moreton on 07/04/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import Foundation

class BaseManager {

    // MARK: Properties

    var operations: OperationQueue

    // MARK: Initializers

    init() {
        operations = OperationQueue()
    }

    /// Initializes a BaseManager subclass
    /// - Parameter maxConcurrentOperationCount: maximun number of concurrent operations
    convenience init(maxConcurrentOperationCount: Int) {
        self.init()

        operations.maxConcurrentOperationCount = maxConcurrentOperationCount
    }

    // MARK: Deinitalizers

    deinit {
        operations.cancelAllOperations()
    }

    // MARK: - Public Methods

    func addOperation(_ block: @escaping () -> Swift.Void) {
        let blockOperation = BlockOperation()

        blockOperation.addExecutionBlock { [weak blockOperation, weak operations] in
            guard let isCancelled = blockOperation?.isCancelled, let isSuspended = operations?.isSuspended, !isCancelled, !isSuspended else { return }

            block()
        }

        operations.addOperation(blockOperation)
    }
}
