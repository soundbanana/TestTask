//
//  AppCoordinator.swift
//  TestTask
//
//  Created by Daniil Chemaev on 26.08.2023.
//

import UIKit
import Swinject

class AppCoordinator: BaseCoordinatorProtocol {
    private var window: UIWindow
    private var resolver: Resolver
    private var childCoordinators: [BaseCoordinatorProtocol] = []

    init(window: UIWindow, resolver: Resolver) {
        self.window = window
        self.resolver = resolver
    }

    func start(animated: Bool) {
        let navigationController = UINavigationController()
        let catalogCoordinator = CatalogCoordinator(navigationController: navigationController, resolver: resolver) { [weak self] in
            self?.childCoordinators.removeCoordinator(ofType: CatalogCoordinator.self)
        }
        catalogCoordinator.start(animated: false)
        childCoordinators.append(catalogCoordinator)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func finish(animated: Bool, completion: (() -> Void)?) {

    }
}
