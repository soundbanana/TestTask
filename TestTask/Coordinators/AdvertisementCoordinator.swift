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

    private var advertisementID: String

    init(navigationController: UINavigationController, resolver: Resolver, advertisementID: String, finishHandler: @escaping (() -> Void)) {
        self.navigationController = navigationController
        self.resolver = resolver
        self.advertisementID = advertisementID
        finishHandlers.append(finishHandler)
    }

    func start(animated: Bool) {
        let viewController = AdvertisementViewController()
        let presenter = AdvertisementPresenter(
            view: viewController,
            coordinator: self,
            service: resolver.resolve(),
            advertisementID: advertisementID
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
