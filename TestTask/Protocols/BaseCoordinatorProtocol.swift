//
//  BaseCoordinatorProtocol.swift
//  TestTask
//
//  Created by Daniil Chemaev on 29.08.2023.
//

import UIKit
import Swinject

protocol BaseCoordinatorProtocol {
    func start(animated: Bool)
    func finish(animated: Bool, completion: (() -> Void)?)
}

extension Array where Element == BaseCoordinatorProtocol {
    func coordinator<T: BaseCoordinatorProtocol>(ofType type: T.Type) -> T? {
        guard let firstCoordinator = first(where: { $0 is T }) as? T else { return nil }
        return firstCoordinator
    }

    mutating func removeCoordinator<T: BaseCoordinatorProtocol>(ofType type: T.Type) {
        guard let index = firstIndex(where: { $0 is T }) else { return }
        remove(at: index)
    }
}

extension Array where Element == BaseCoordinatorProtocol {
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
