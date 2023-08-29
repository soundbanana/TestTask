//
//  CatalogCoordinatorProtocol.swift
//  TestTask
//
//  Created by Daniil Chemaev on 26.08.2023.
//

import UIKit

protocol CatalogCoordinatorProtocol: BaseCoordinatorProtocol {
    func start()
    func navigateToAdvertisementDetails(advertisement: Advertisement)
}
