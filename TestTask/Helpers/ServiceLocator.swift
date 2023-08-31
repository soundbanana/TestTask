//
//  ServiceLocator.swift
//  TestTask
//
//  Created by Daniil Chemaev on 29.08.2023.
//

import Swinject

/// A protocol that defines the required methods for a service locator.
protocol ServiceLocatorProtocol {
    /// Retrieves the Swinject Resolver instance.
    /// - Returns: The Swinject Resolver instance.
    func getResolver() -> Resolver
}

/// A concrete implementation of the ServiceLocatorProtocol that uses Swinject to manage dependencies.
final class ServiceLocator: ServiceLocatorProtocol {
    // MARK: - Properties

    private var container: Container
    private var assembler: Assembler

    // MARK: - Initialization

    /// Initializes the ServiceLocator with a default configuration.
    init() {
        self.container = Container()
        self.assembler = Assembler(
            [
                AdvertisementsServiceAssembly(),
                AdvertisementServiceAssembly(),
            ],
            container: container
        )
    }

    // MARK: - ServiceLocatorProtocol

    /// Retrieves the Swinject Resolver instance.
    /// - Returns: The Swinject Resolver instance.
    func getResolver() -> Resolver {
        return assembler.resolver
    }
}
