//
//  CatalogPresenter.swift
//  TestTask
//
//  Created by Daniil Chemaev on 26.08.2023.
//

import UIKit

// MARK: - CatalogViewProtocol

protocol CatalogViewProtocol: AnyObject {
    // Show loading indicator
    func showLoading()

    // Hide loading indicator
    func hideLoading()

    // Show content (e.g., after successful data loading)
    func showContent()

    // Hide content (e.g., when an error is shown)
    func hideContent()

    // Show an error message
    func showError(_ error: String)

    // Hide the error message
    func hideError()
}

// MARK: - CatalogPresenterProtocol

protocol CatalogPresenterProtocol {
    func configureDataSource(for collectionView: UICollectionView)
    func viewDidLoadEvent()
    func advertisementCellTapped(at indexPath: IndexPath)
}

class CatalogPresenter: CatalogPresenterProtocol {
    // MARK: Properties

    var view: CatalogViewProtocol?
    var coordinator: CatalogCoordinatorProtocol?
    var service: AdvertisementsServiceProtocol

    private var dataSource: UICollectionViewDiffableDataSource<Int, Advertisement>!

    // MARK: Initialization

    required init(view: CatalogViewProtocol?, coordinator: CatalogCoordinatorProtocol?, service: AdvertisementsServiceProtocol) {
        self.view = view
        self.coordinator = coordinator
        self.service = service
    }

    // MARK: - CatalogPresenterProtocol

    func viewDidLoadEvent() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.hideContent()
            self?.view?.hideError()
            self?.view?.showLoading()
        }

        fetchAdvertisements() { [weak self] status in
            switch status {
            case .success(let response):
                // If fetching was successful, update the UI with the fetched advertisements
                var snapshot = NSDiffableDataSourceSnapshot<Int, Advertisement>()
                snapshot.appendSections([0])
                snapshot.appendItems(response.advertisements)
                self?.dataSource.apply(snapshot, animatingDifferences: true)
                DispatchQueue.main.async {
                    self?.view?.hideLoading()
                    self?.view?.hideError()
                    self?.view?.showContent()
                }

            case .failure(let error):
                DispatchQueue.main.async {
                    self?.view?.hideLoading()
                    self?.view?.hideContent()
                    self?.view?.showError(error.localizedDescription)
                }
            }
        }
    }

    func configureDataSource(for collectionView: UICollectionView) {
        dataSource = UICollectionViewDiffableDataSource<Int, Advertisement>(collectionView: collectionView) { collectionView, indexPath, advertisement in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatalogCollectionViewCell.reuseIdentifier, for: indexPath) as? CatalogCollectionViewCell else {
                fatalError("Unable to dequeue CustomCollectionViewCell")
            }
            cell.configure(with: advertisement)
            return cell
        }
        collectionView.register(CatalogCollectionViewCell.self, forCellWithReuseIdentifier: CatalogCollectionViewCell.reuseIdentifier)
    }

    func advertisementCellTapped(at indexPath: IndexPath) {
        if let selectedAdvertisement = dataSource?.itemIdentifier(for: indexPath) {
            coordinator?.navigateToAdvertisementDetails(with: selectedAdvertisement.id)
        }
    }

    // MARK: Private Methods

    private func fetchAdvertisements(completion: @escaping (FetchingAdvertisementsResult) -> Void) {
        service.fetchAdvertisements { result in
            switch result {
            case .success(let response):
                completion(.success(value: response))

            case .failure(let error):
                print("Error fetching advertisements: \(error.localizedDescription)")
                completion(.failure(error: error))
            }
        }
    }
}

enum FetchingAdvertisementsResult {
    case success(value: AdvertisementResponse)
    case failure(error: Error)
}
