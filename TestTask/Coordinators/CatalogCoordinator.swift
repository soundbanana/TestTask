//
//  CatalogCoordinator.swift
//  TestTask
//
//  Created by Daniil Chemaev on 26.08.2023.
//

import UIKit
import Swinject

class CatalogCoordinator: CatalogCoordinatorProtocol {
    private var navigationController: UINavigationController
    private var resolver: Resolver
    private var childCoordinators: [BaseCoordinatorProtocol] = []
    private var finishHandlers: [(() -> Void)] = []

    required init(navigationController: UINavigationController, resolver: Resolver, finishHandler: @escaping (() -> Void)) {
        self.navigationController = navigationController
        self.resolver = resolver
        self.finishHandlers.append(finishHandler)
    }

    func start(animated: Bool) {
        let viewController = CatalogViewController()
        viewController.presenter = CatalogPresenter(
            view: viewController,
            coordinator: self,
            service: resolver.resolve()
        )
        navigationController.pushViewController(viewController, animated: animated)
    }

    func navigateToAdvertisementDetails(advertisement: Advertisement) {
        let coordinator = AdvertisementCoordinator(
            navigationController: navigationController,
            resolver: resolver
        ) {
            [weak self] in
            self?.childCoordinators.removeCoordinator(ofType: AdvertisementCoordinator.self)
        }
        coordinator.start(animated: false)
        childCoordinators.append(coordinator)
    }

    func finish(animated: Bool, completion: (() -> Void)?) {
        guard let finishHandler = completion else { return }
        finishHandlers.append(finishHandler)
        childCoordinators.finishAll(animated: animated, completion: nil)
    }
}
