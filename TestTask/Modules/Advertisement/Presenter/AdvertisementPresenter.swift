//
//  AdvertisementPresenter.swift
//  TestTask
//
//  Created by Daniil Chemaev on 29.08.2023.
//

import Foundation

// MARK: - AdvertisementViewProtocol

protocol AdvertisementViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func showContent(_ advertisement: AdvertisementDetails)
    func showError(_ error: String)
    func hideError()
}

// MARK: - AdvertisementPresenterProtocol

protocol AdvertisementPresenterProtocol {
    func fetchAdvertisement()
}

class AdvertisementPresenter: AdvertisementPresenterProtocol {
    // MARK: - Properties

    private var view: AdvertisementViewProtocol?
    private var coordinator: AdvertisementCoordinatorProtocol?
    private var service: AdvertisementServiceProtocol

    private let advertisementID: String

    // MARK: - Initialization

    required init(view: AdvertisementViewProtocol?, coordinator: AdvertisementCoordinatorProtocol?, service: AdvertisementServiceProtocol, advertisementID: String) {
        self.view = view
        self.coordinator = coordinator
        self.service = service
        self.advertisementID = advertisementID
        fetchAdvertisement()
    }

    // MARK: - Fetch Advertisement

    func fetchAdvertisement() {
        view?.showLoading()

        service.fetchAdvertisement(advertisementID: advertisementID) { [weak self] result in
            switch result {
            case .success(let advertisement):
                DispatchQueue.main.async {
                    self?.view?.showContent(advertisement)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.view?.showError("Error fetching advertisement: \(error.localizedDescription)")
                }
            }
        }
    }
}
