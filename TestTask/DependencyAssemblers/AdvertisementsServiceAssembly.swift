//
//  AdvertisementsServiceAssembly.swift
//  TestTask
//
//  Created by Daniil Chemaev on 29.08.2023.
//

import Swinject

final class AdvertisementsServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AdvertisementsService.self) { resolver in
            return AdvertisementsService()
        }
    }
}
