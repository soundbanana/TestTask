//
//  CatalogCoordinator.swift
//  TestTask
//
//  Created by Daniil Chemaev on 26.08.2023.
//

import UIKit
import Swinject

// MARK: - CatalogCoordinatorProtocol

protocol CatalogCoordinatorProtocol: BaseCoordinatorProtocol {
    // Initialize the CatalogCoordinator with the required parameters.
    init(navigationController: UINavigationController, resolver: Resolver, finishHandler: @escaping (() -> Void))

    // Navigate to the advertisement details screen.
    func navigateToAdvertisementDetails(with id: String)
}

class CatalogCoordinator: CatalogCoordinatorProtocol {
    // MARK: - Properties

    private var navigationController: UINavigationController
    private var resolver: Resolver
    private var childCoordinators: [BaseCoordinatorProtocol] = []
    private var finishHandlers: [(() -> Void)] = []

    // MARK: - Initialization

    required init(navigationController: UINavigationController, resolver: Resolver, finishHandler: @escaping (() -> Void)) {
        self.navigationController = navigationController
        self.resolver = resolver
        self.finishHandlers.append(finishHandler)
    }

    // MARK: - Coordinator Lifecycle

    func start(animated: Bool) {
        // Create and configure the CatalogViewController
        let viewController = CatalogViewController()
        viewController.presenter = CatalogPresenter(
            view: viewController,
            coordinator: self,
            service: resolver.resolve()
        )

        // Push the CatalogViewController onto the navigation stack
        navigationController.pushViewController(viewController, animated: animated)
    }

    func navigateToAdvertisementDetails(with id: String) {
        // Create and start the AdvertisementCoordinator for details screen
        let coordinator = AdvertisementCoordinator(
            navigationController: navigationController,
            resolver: resolver,
            advertisementID: id
        ) {
            [weak self] in
            self?.childCoordinators.removeCoordinator(ofType: AdvertisementCoordinator.self)
        }
        coordinator.start(animated: false)
        childCoordinators.append(coordinator)
    }

    func finish(animated: Bool, completion: (() -> Void)?) {
        // Add finish handler to the list
        guard let finishHandler = completion else { return }
        finishHandlers.append(finishHandler)

        // Finish all child coordinators
        childCoordinators.finishAll(animated: animated, completion: nil)
    }
}
