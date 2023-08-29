//
//  AppCoordinator.swift
//  TestTask
//
//  Created by Daniil Chemaev on 26.08.2023.
//

import UIKit

class AppCoordinator {
    
    private var window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let navigationController = UINavigationController()
        let catalogCoordinator = CatalogCoordinator(navigationController: navigationController)
        catalogCoordinator.start()

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
