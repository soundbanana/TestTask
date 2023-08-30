//
//  AdvertisementCoordinator.swift
//  TestTask
//
//  Created by Daniil Chemaev on 29.08.2023.
//

import UIKit
import Swinject

// MARK: - AdvertisementCoordinatorProtocol

protocol AdvertisementCoordinatorProtocol: BaseCoordinatorProtocol {}

class AdvertisementCoordinator: AdvertisementCoordinatorProtocol {
    // MARK: - Properties

    private var navigationController: UINavigationController
    private weak var parentTabBarController: UITabBarController?
    private var resolver: Resolver
    private var childCoordinators: [BaseCoordinatorProtocol] = []
    private var finishHandlers: [(() -> Void)] = []

    private var advertisementID: String

    // MARK: - Initialization

    init(navigationController: UINavigationController, resolver: Resolver, advertisementID: String, finishHandler: @escaping (() -> Void)) {
        self.navigationController = navigationController
        self.resolver = resolver
        self.advertisementID = advertisementID
        finishHandlers.append(finishHandler)
    }

    // MARK: - Coordinator Lifecycle

    func start(animated: Bool) {
        // Create and configure AdvertisementViewController
        let viewController = AdvertisementViewController()
        let presenter = AdvertisementPresenter(
            view: viewController,
            coordinator: self,
            service: resolver.resolve(),
            advertisementID: advertisementID
        )
        viewController.presenter = presenter

        // Push the AdvertisementViewController onto the navigation stack
        navigationController.pushViewController(viewController, animated: true)
    }

    func finish(animated: Bool, completion: (() -> Void)?) {
        // Add finish handler to the list
        guard let finishHandler = completion else { return }
        finishHandlers.append(finishHandler)

        // Finish all child coordinators
        childCoordinators.finishAll(animated: animated, completion: nil)
    }
}
