//
//  CatalogPresenter.swift
//  TestTask
//
//  Created by Daniil Chemaev on 26.08.2023.
//

import UIKit

protocol CatalogViewProtocol: AnyObject {
}

protocol CatalogPresenterProtocol {
    var view: CatalogViewProtocol? { get set }
    var coordinator: CatalogCoordinatorProtocol? { get set }

    init(view: CatalogViewProtocol?, coordinator: CatalogCoordinatorProtocol?)

    func configureDataSource(for collectionView: UICollectionView)
    func viewDidLoadEvent()
    func advertisementCellTapped(at indexPath: IndexPath)
}

class CatalogPresenter: CatalogPresenterProtocol {
    var view: CatalogViewProtocol?
    var coordinator: CatalogCoordinatorProtocol?

    private var dataSource: UICollectionViewDiffableDataSource<Int, Advertisement>!

    required init(view: CatalogViewProtocol?, coordinator: CatalogCoordinatorProtocol?) {
        self.view = view
        self.coordinator = coordinator
    }

    private func fetchAdvertisements() {
        AdvertisementsService().fetchAdvertisements { [weak self] result in
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
            coordinator?.navigateToAdvertisementDetails(advertisement: selectedAdvertisement)
        }
    }
}
