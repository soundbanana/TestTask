//
//  AdvertisementServiceAssembly.swift
//  TestTask
//
//  Created by Daniil Chemaev on 29.08.2023.
//

import Swinject

final class AdvertisementServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AdvertisementServiceProtocol.self) { resolver in
            return AdvertisementService()
        }
    }
}
