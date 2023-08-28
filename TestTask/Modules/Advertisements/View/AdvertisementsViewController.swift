//
//  ViewController.swift
//  TestTask
//
//  Created by Daniil Chemaev on 26.08.2023.
//

import UIKit

class AdvertisementsViewController: UIViewController, AdvertisementsViewProtocol {
    var presenter: AdvertisementsPresenterProtocol!

    private let spacingBetweenCells: CGFloat = 10.0

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .red
        collectionView.register(AdvertisementsCollectionViewCell.self, forCellWithReuseIdentifier: AdvertisementsCollectionViewCell.reuseIdentifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter.configureDataSource(for: collectionView)
        presenter.viewDidLoadEvent()
    }

    private func setupViews() {
        view.backgroundColor = .gray
        view.addSubview(collectionView)

//        presenter.configureDataSource(for: collectionView)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
        ])
    }

    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(150))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacingBetweenCells, bottom: 0, trailing: 0)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

//extension AdvertisementsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        presenter.numberOfAdvertisements
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdvertisementsCollectionViewCell.reuseIdentifier, for: indexPath) as? AdvertisementsCollectionViewCell else {
//            fatalError("Unable to dequeue CustomCollectionViewCell")
//        }
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let collectionViewWidth = collectionView.frame.width
//        let cellWidth = (collectionViewWidth - spacingBetweenCells) / 2
//        let cellHeight: CGFloat = 150
//
//        return CGSize(width: cellWidth, height: cellHeight)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return spacingBetweenCells
//    }
//}
