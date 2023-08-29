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
    var coordinator: CoordinatorProtocol? { get set }

    init(view: AdvertisementsViewProtocol?, coordinator: CoordinatorProtocol?)

    func configureDataSource(for collectionView: UICollectionView)
    func viewDidLoadEvent()
}

class AdvertisementsPresenter: AdvertisementsPresenterProtocol {
    var view: AdvertisementsViewProtocol?
    var coordinator: CoordinatorProtocol?

    private var dataSource: UICollectionViewDiffableDataSource<Int, Advertisement>!

    required init(view: AdvertisementsViewProtocol?, coordinator: CoordinatorProtocol?) {
        self.view = view
        self.coordinator = coordinator
    }

    private func fetchAdvertisements() {
        AdvertisementsService().fetchAdvertisements { [weak self] result in
            switch result {
            case .success(let response):
                print(response)
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
        var snapshot = NSDiffableDataSourceSnapshot<Int, Advertisement>()
        snapshot.appendSections([0])

        snapshot.appendItems([])

        dataSource.apply(snapshot, animatingDifferences: true)

        fetchAdvertisements()
    }

    func configureDataSource(for collectionView: UICollectionView) {
        dataSource = UICollectionViewDiffableDataSource<Int, Advertisement>(collectionView: collectionView) { collectionView, indexPath, advertisement in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdvertisementsCollectionViewCell.reuseIdentifier, for: indexPath) as? AdvertisementsCollectionViewCell else {
                fatalError("Unable to dequeue CustomCollectionViewCell")
            }
            cell.configure(with: advertisement) // Pass the advertisement data to the cell's configure method
            return cell
        }
    }
}
