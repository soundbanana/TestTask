//
//  AdvertisementCoordinator.swift
//  TestTask
//
//  Created by Daniil Chemaev on 29.08.2023.
//

import UIKit
import Swinject

class AdvertisementCoordinator: AdvertisementCoordinatorProtocol {
    private var navigationController: UINavigationController
    private weak var parentTabBarController: UITabBarController?
    private var resolver: Resolver
    private var childCoordinators: [BaseCoordinatorProtocol] = []
    private var finishHandlers: [(() -> Void)] = []

    init(navigationController: UINavigationController, resolver: Resolver, finishHandler: @escaping (() -> Void)) {
        self.navigationController = navigationController
        self.resolver = resolver
        finishHandlers.append(finishHandler)
    }

    func start(animated: Bool) {
        let viewController = AdvertisementViewController()
        let presenter = AdvertisementPresenter(
            view: viewController,
            coordinator: self,
            service: resolver.resolve(),
            itemId: "1"
        )
        viewController.presenter = presenter
        navigationController.pushViewController(viewController, animated: true)
    }

    func finish(animated: Bool, completion: (() -> Void)?) {
        guard let finishHandler = completion else { return }
        finishHandlers.append(finishHandler)
        childCoordinators.finishAll(animated: animated, completion: nil)
    }
}
