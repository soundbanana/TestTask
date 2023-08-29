//
//  CoordinatorProtocol.swift
//  TestTask
//
//  Created by Daniil Chemaev on 26.08.2023.
//

import UIKit

protocol MainCoordinatorProtocol: BaseCoordinatorProtocol {
    func start()
    func navigateToAdvertisementDetails(advertisement: Advertisement)
}
