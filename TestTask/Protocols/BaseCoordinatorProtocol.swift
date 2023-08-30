//
//  BaseCoordinatorProtocol.swift
//  TestTask
//
//  Created by Daniil Chemaev on 29.08.2023.
//

import UIKit
import Swinject

// Protocol defining the basic structure and behavior of a coordinator.
protocol BaseCoordinatorProtocol {
    func start(animated: Bool)
    func finish(animated: Bool, completion: (() -> Void)?)
}

// Extension on Array to provide utility methods for managing coordinators.
extension Array where Element == BaseCoordinatorProtocol {
    // Retrieve a coordinator of a specific type from the array.
    func coordinator<T: BaseCoordinatorProtocol>(ofType type: T.Type) -> T? {
        guard let firstCoordinator = first(where: { $0 is T }) as? T else { return nil }
        return firstCoordinator
    }

    // Remove a coordinator of a specific type from the array.
    mutating func removeCoordinator<T: BaseCoordinatorProtocol>(ofType type: T.Type) {
        guard let index = firstIndex(where: { $0 is T }) else { return }
        remove(at: index)
    }
}

// Extension on Array of BaseCoordinatorProtocol to provide a method for finishing all coordinators sequentially.
extension Array where Element == BaseCoordinatorProtocol {
    // Finish all coordinators in the array sequentially.
    func finishAll(animated: Bool, completion: (() -> Void)?) {
        guard let coordinator = self.first else {
            completion?()
            return
        }

        coordinator.finish(animated: animated) {
            var arr = self
            arr.removeFirst()
            arr.finishAll(animated: animated, completion: completion)
        }
    }
}

