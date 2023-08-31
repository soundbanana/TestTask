//
//  CatalogViewController.swift
//  TestTask
//
//  Created by Daniil Chemaev on 26.08.2023.
//

import UIKit

class CatalogViewController: UIViewController, CatalogViewProtocol {
    // MARK: - Properties

    var presenter: CatalogPresenterProtocol!

    // MARK: - UI Elements

    private lazy var errorView: ErrorView = {
        let view = ErrorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var loadingSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        return collectionView
    }()

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter.configureDataSource(for: collectionView)
        presenter.viewDidLoadEvent()
    }

    // MARK: - UI Setup

    private func setupViews() {
        title = "Товары"
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    // MARK: - CatalogViewProtocol

    func showLoading() {
        loadingSpinner = UIActivityIndicatorView(style: .large)
        loadingSpinner.center = self.view.center
        self.view.addSubview(loadingSpinner)
        loadingSpinner.startAnimating()
    }

    func hideLoading() {
        self.loadingSpinner.stopAnimating()
    }

    func showContent() {
        collectionView.isHidden = false
    }

    func hideContent() {
        collectionView.isHidden = true
    }

    func showError(_ error: String) {
        errorView.configure(message: error)
        setupErrorView()
        errorView.isHidden = false
    }

    func hideError() {
        errorView.isHidden = true
    }

    private func setupErrorView() {
        view.addSubview(errorView)
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        errorView.isHidden = true
        errorView.onRetryButtonTapped = { [weak self] in
            self?.presenter.viewDidLoadEvent()
        }
    }

    // MARK: - UICollectionViewLayout

    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(300))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

// MARK: - UICollectionViewDelegate

extension CatalogViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.advertisementCellTapped(at: indexPath)
    }
}
