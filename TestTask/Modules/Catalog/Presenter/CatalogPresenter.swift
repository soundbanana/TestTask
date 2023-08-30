//
//  CatalogPresenter.swift
//  TestTask
//
//  Created by Daniil Chemaev on 26.08.2023.
//

import UIKit

// MARK: - CatalogViewProtocol

protocol CatalogViewProtocol: AnyObject {}

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

    // MARK: Private Methods

    private func fetchAdvertisements() {
        service.fetchAdvertisements { [weak self] result in
            switch result {
            case .success(let response):
                var snapshot = NSDiffableDataSourceSnapshot<Int, Advertisement>()
                snapshot.appendSections([0])
                snapshot.appendItems(response.advertisements)
                self?.dataSource.apply(snapshot, animatingDifferences: true)

            case .failure(let error):
                print("Error fetching advertisements: \(error.localizedDescription)")
            }
        }
    }

    // MARK: Public Methods

    func viewDidLoadEvent() {
        fetchAdvertisements()
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
        if let selectedAdvertisement = dataSource.itemIdentifier(for: indexPath) {
            coordinator?.navigateToAdvertisementDetails(with: selectedAdvertisement.id)
        }
    }
}
