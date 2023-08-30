//
//  AppCoordinator.swift
//  TestTask
//
//  Created by Daniil Chemaev on 26.08.2023.
//

import UIKit
import Swinject

class AppCoordinator: BaseCoordinatorProtocol {
    // MARK: - Properties

    private var window: UIWindow
    private var resolver: Resolver
    private var childCoordinators: [BaseCoordinatorProtocol] = []

    // MARK: - Initialization

    init(window: UIWindow, resolver: Resolver) {
        self.window = window
        self.resolver = resolver
    }

    // MARK: - Coordinator Lifecycle

    func start(animated: Bool) {
        // Initialize the main navigation controller
        let navigationController = UINavigationController()

        // Create and start the catalog coordinator
        let catalogCoordinator = CatalogCoordinator(navigationController: navigationController, resolver: resolver) { [weak self] in
            self?.childCoordinators.removeCoordinator(ofType: CatalogCoordinator.self)
        }
        catalogCoordinator.start(animated: false)
        childCoordinators.append(catalogCoordinator)

        // Set the navigation controller as the root view controller
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func finish(animated: Bool, completion: (() -> Void)?) {
        // Implement any necessary cleanup or completion logic
    }
}
