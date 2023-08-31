//
//  AdvertisementViewController.swift
//  TestTask
//
//  Created by Daniil Chemaev on 29.08.2023.
//

import UIKit
import Kingfisher

class AdvertisementViewController: UIViewController, AdvertisementViewProtocol {
    // MARK: - Properties

    var presenter: AdvertisementPresenterProtocol!

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

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var advertisementImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var createdDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupViews()
        presenter.viewDidLoadEvent()
    }

    private func setupScrollView() {
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    // MARK: - UI Setup

    private func setupViews() {
        contentView.addSubviews(
            advertisementImageView,
            titleLabel,
            priceLabel,
            locationLabel,
            createdDateLabel,
            descriptionTitleLabel,
            descriptionLabel,
            emailLabel,
            phoneNumberLabel,
            addressLabel
        )

        setupConstraints()
    }

    private func setupConstraints() {
        let padding: CGFloat = 16.0

        NSLayoutConstraint.activate([
            advertisementImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: padding),
            advertisementImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            advertisementImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            advertisementImageView.heightAnchor.constraint(equalToConstant: 300),

            priceLabel.topAnchor.constraint(equalTo: advertisementImageView.bottomAnchor, constant: padding / 2),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),

            titleLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: padding / 4),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),

            locationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding / 4),
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),

            addressLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: padding / 4),
            addressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            addressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),

            emailLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: padding / 2),
            emailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            emailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),

            phoneNumberLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: padding / 4),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),

            descriptionTitleLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: padding / 2),
            descriptionTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            descriptionTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),

            descriptionLabel.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: padding / 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),

            createdDateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: padding / 2),
            createdDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            createdDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: padding),
            createdDateLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
    }

    // MARK: - AdvertisementViewProtocol

    func showLoading() {
        loadingSpinner = UIActivityIndicatorView(style: .large)
        loadingSpinner.center = self.view.center
        self.view.addSubview(loadingSpinner)
        loadingSpinner.startAnimating()
    }

    func hideLoading() {
        self.loadingSpinner.stopAnimating()
    }

    func showContent(_ advertisement: AdvertisementDetails) {
        contentView.isHidden = false
        titleLabel.text = advertisement.title
        priceLabel.text = advertisement.price
        locationLabel.text = advertisement.location
        createdDateLabel.text = advertisement.createdDate
        descriptionLabel.text = advertisement.description
        descriptionTitleLabel.text = "Описание"
        emailLabel.text = advertisement.email
        phoneNumberLabel.text = advertisement.phoneNumber
        addressLabel.text = advertisement.address

        let url = URL(string: advertisement.imageURL)
        advertisementImageView.kf.setImage(with: url)
    }

    func hideContent() {
        contentView.isHidden = true
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
}
