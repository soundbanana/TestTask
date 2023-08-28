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

    //    var numberOfAdvertisements: Int { get }

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
        AdvertisementsService().fetchAdvertisements { result in
            switch result {
            case .success(let response):
                print(response)
                var snapshot = NSDiffableDataSourceSnapshot<Int, Advertisement>()
                snapshot.appendSections([0])
                snapshot.appendItems(response.advertisements)
//                self.view?.applySnapshot(snapshot)

            case .failure(let error):
                print("Error fetching advertisements: \(error.localizedDescription)")
            }
        }
    }

    func viewDidLoadEvent() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Advertisement>()
        snapshot.appendSections([0])
        snapshot.appendItems([
            Advertisement(id: "1", title: "1", price: "2", location: "2", imageURL: "123", createdDate: "123"),
            Advertisement(id: "2", title: "1", price: "2", location: "2", imageURL: "123", createdDate: "123"),
            Advertisement(id: "3", title: "1", price: "2", location: "2", imageURL: "123", createdDate: "123"),
            Advertisement(id: "4", title: "1", price: "2", location: "2", imageURL: "123", createdDate: "123"),
            Advertisement(id: "5", title: "1", price: "2", location: "2", imageURL: "123", createdDate: "123"),
            Advertisement(id: "6", title: "1", price: "2", location: "2", imageURL: "123", createdDate: "123"),
            Advertisement(id: "7", title: "1", price: "2", location: "2", imageURL: "123", createdDate: "123"),
            Advertisement(id: "8", title: "1", price: "2", location: "2", imageURL: "123", createdDate: "123"),
            Advertisement(id: "9", title: "1", price: "2", location: "2", imageURL: "123", createdDate: "123"),
            Advertisement(id: "10", title: "1", price: "2", location: "2", imageURL: "123", createdDate: "123")
        ])

        dataSource.apply(snapshot, animatingDifferences: true)

        fetchAdvertisements()
    }

    func configureDataSource(for collectionView: UICollectionView) {
        dataSource = UICollectionViewDiffableDataSource<Int, Advertisement>(collectionView: collectionView) { collectionView, indexPath, advertisement in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdvertisementsCollectionViewCell.reuseIdentifier, for: indexPath) as? AdvertisementsCollectionViewCell else {
                fatalError("Unable to dequeue CustomCollectionViewCell")
            }
            return cell
        }
    }
}
