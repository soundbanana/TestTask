//
//  MainPresenter.swift
//  TestTask
//
//  Created by Daniil Chemaev on 26.08.2023.
//

import UIKit

protocol AdvertisementsViewProtocol: AnyObject {
}

protocol AdvertisementsPresenterProtocol {
    var view: AdvertisementsViewProtocol? { get set }
    var coordinator: MainCoordinatorProtocol? { get set }

    init(view: AdvertisementsViewProtocol?, coordinator: MainCoordinatorProtocol?)

    func configureDataSource(for collectionView: UICollectionView)
    func viewDidLoadEvent()
    func advertisementCellTapped(at indexPath: IndexPath)
}

class AdvertisementsPresenter: AdvertisementsPresenterProtocol {
    var view: AdvertisementsViewProtocol?
    var coordinator: MainCoordinatorProtocol?

    private var dataSource: UICollectionViewDiffableDataSource<Int, Advertisement>!

    required init(view: AdvertisementsViewProtocol?, coordinator: MainCoordinatorProtocol?) {
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdvertisementsCollectionViewCell.reuseIdentifier, for: indexPath) as? AdvertisementsCollectionViewCell else {
                fatalError("Unable to dequeue CustomCollectionViewCell")
            }
            cell.configure(with: advertisement)
            return cell
        }
        collectionView.register(AdvertisementsCollectionViewCell.self, forCellWithReuseIdentifier: AdvertisementsCollectionViewCell.reuseIdentifier)
    }

    func advertisementCellTapped(at indexPath: IndexPath) {
        if let selectedAdvertisement = dataSource.itemIdentifier(for: indexPath) {
            coordinator?.navigateToAdvertisementDetails(advertisement: selectedAdvertisement)
        }
    }
}
