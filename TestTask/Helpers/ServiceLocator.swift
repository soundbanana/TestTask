//
//  ServiceLocator.swift
//  TestTask
//
//  Created by Daniil Chemaev on 29.08.2023.
//

import Swinject

protocol ServiceLocatorProtocol {
    func getResolver() -> Resolver
}

final class ServiceLocator: ServiceLocatorProtocol {
    private var container: Container
    private var assembler: Assembler

    init() {
        self.container = Container()
        self.assembler = Assembler(
            [
                AdvertisementsServiceAssembly(),
            ],
            container: container
        )
    }

    func getResolver() -> Resolver {
        return assembler.resolver
    }
}
