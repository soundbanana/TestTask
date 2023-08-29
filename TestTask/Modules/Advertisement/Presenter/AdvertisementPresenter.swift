//
//  AdvertisementPresenter.swift
//  TestTask
//
//  Created by Daniil Chemaev on 29.08.2023.
//

import Foundation

protocol AdvertisementViewProtocol: AnyObject {
}

protocol AdvertisementPresenterProtocol {
    var view: AdvertisementViewProtocol? { get set }
    var coordinator: AdvertisementCoordinatorProtocol? { get set }

    init(view: AdvertisementViewProtocol?, coordinator: AdvertisementCoordinatorProtocol?)
}

class AdvertisementPresenter: AdvertisementPresenterProtocol {
    var view: AdvertisementViewProtocol?

    var coordinator: AdvertisementCoordinatorProtocol?

    required init(view: AdvertisementViewProtocol?, coordinator: AdvertisementCoordinatorProtocol?) {
        self.view = view
        self.coordinator = coordinator
    }    
}
