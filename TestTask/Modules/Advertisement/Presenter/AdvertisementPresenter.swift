//
//  AdvertisementPresenter.swift
//  TestTask
//
//  Created by Daniil Chemaev on 29.08.2023.
//

import Foundation

protocol AdvertisementViewProtocol: AnyObject {
    func showLoading()
    func showContent(_ advertisement: AdvertisementDetails)
    func showError(_ error: String)
}

protocol AdvertisementPresenterProtocol {
}

class AdvertisementPresenter: AdvertisementPresenterProtocol {
    private var view: AdvertisementViewProtocol?
    private var coordinator: AdvertisementCoordinatorProtocol?
    private var service: AdvertisementServiceProtocol

    private let advertisementID: String

    required init(view: AdvertisementViewProtocol?, coordinator: AdvertisementCoordinatorProtocol?, service: AdvertisementServiceProtocol, advertisementID: String) {
        self.view = view
        self.coordinator = coordinator
        self.service = service
        self.advertisementID = advertisementID
        fetchAdvertisement()
    }

    private func fetchAdvertisement() {
        view?.showLoading()

        service.fetchAdvertisement(advertisementID: advertisementID) { result in
            switch result {
            case .success(let advertisement):
                DispatchQueue.main.async {
                    self.view?.showContent(advertisement)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view?.showError("Error fetching advertisement: \(error.localizedDescription)")
                }
            }
        }
    }
}
