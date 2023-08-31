//
//  AdvertisementPresenter.swift
//  TestTask
//
//  Created by Daniil Chemaev on 29.08.2023.
//

import Foundation

// MARK: - AdvertisementViewProtocol

protocol AdvertisementViewProtocol: AnyObject {
    // Show loading indicator
    func showLoading()

    // Hide loading indicator
    func hideLoading()

    // Show content (e.g., after successful data loading)
    func showContent(_ advertisement: AdvertisementDetails)

    // Hide content (e.g., when an error is shown)
    func hideContent()

    // Show an error message
    func showError(_ error: String)

    // Hide the error message
    func hideError()
}

// MARK: - AdvertisementPresenterProtocol

protocol AdvertisementPresenterProtocol {
    func viewDidLoadEvent()
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
    }

    // MARK: - AdvertisementPresenterProtocol

    func viewDidLoadEvent() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.hideContent()
            self?.view?.hideError()
            self?.view?.showLoading()
        }

        fetchAdvertisement() { [weak self] status in
            switch status {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.view?.hideLoading()
                    self?.view?.hideError()
                    self?.view?.showContent(response)
                }

            case .failure(let error):
                DispatchQueue.main.async {
                    self?.view?.hideLoading()
                    self?.view?.hideContent()
                    self?.view?.showError("Error fetching advertisement: \(error.localizedDescription)")
                }
            }
        }
    }

    // MARK: - Private Methods

    private func fetchAdvertisement(completion: @escaping (FerchingAdvertisementResult) -> Void) {
        service.fetchAdvertisement(advertisementID: advertisementID) { result in
            switch result {
            case .success(let advertisement):
                completion(.success(value: advertisement))
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
}

enum FerchingAdvertisementResult {
    case success(value: AdvertisementDetails)
    case failure(error: Error)
}
