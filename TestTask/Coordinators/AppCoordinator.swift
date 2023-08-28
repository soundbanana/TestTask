//
//  AppCoordinator.swift
//  TestTask
//
//  Created by Daniil Chemaev on 26.08.2023.
//

import UIKit

class AppCoordinator: CoordinatorProtocol {
    
    private var window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let navigationController = UINavigationController()
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        mainCoordinator.start()

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
