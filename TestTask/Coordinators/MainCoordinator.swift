//
//  MainCoordinator.swift
//  TestTask
//
//  Created by Daniil Chemaev on 26.08.2023.
//

import UIKit

class MainCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = AdvertisementsViewController()
        
        viewController.presenter = AdvertisementsPresenter(view: viewController, coordinator: self)

        navigationController.pushViewController(viewController, animated: false)
    }

    func showDetails(with advertisement: Advertisement){
        print("Showing \(advertisement.title) details view")
    }
}
