//
//  AdvertisementViewController.swift
//  TestTask
//
//  Created by Daniil Chemaev on 29.08.2023.
//

import UIKit
import Kingfisher

class AdvertisementViewController: UIViewController, AdvertisementViewProtocol {
    var presenter: AdvertisementPresenterProtocol!

    private lazy var advertisementImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
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
        label.font = UIFont.boldSystemFont(ofSize: 20)
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

    private lazy var createdDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.text = "Описание"
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

    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
    }

    private func setupViews() {
        view.addSubviews(
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
            advertisementImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            advertisementImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            advertisementImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            advertisementImageView.heightAnchor.constraint(equalToConstant: 300),

            priceLabel.topAnchor.constraint(equalTo: advertisementImageView.bottomAnchor, constant: padding / 2),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),

            titleLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: padding / 4),
            titleLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor),

            locationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding / 4),
            locationLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),

            addressLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor),
            addressLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: locationLabel.trailingAnchor),

            createdDateLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: padding / 4),
            createdDateLabel.leadingAnchor.constraint(equalTo: addressLabel.leadingAnchor),
            createdDateLabel.trailingAnchor.constraint(equalTo: addressLabel.trailingAnchor),

            descriptionTitleLabel.topAnchor.constraint(equalTo: createdDateLabel.bottomAnchor, constant: padding / 2),
            descriptionTitleLabel.leadingAnchor.constraint(equalTo: createdDateLabel.leadingAnchor),
            descriptionTitleLabel.trailingAnchor.constraint(equalTo: createdDateLabel.trailingAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: padding / 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionTitleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionTitleLabel.trailingAnchor),

            emailLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: padding / 2),
            emailLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),

            phoneNumberLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: padding / 4),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            phoneNumberLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
    }

    func showLoading() {

    }

    func showContent(_ advertisement: AdvertisementDetails) {
        titleLabel.text = advertisement.title
        priceLabel.text = advertisement.price
        locationLabel.text = advertisement.location
        createdDateLabel.text = advertisement.createdDate
        descriptionLabel.text = advertisement.description
        emailLabel.text = advertisement.email
        phoneNumberLabel.text = advertisement.phoneNumber
        addressLabel.text = advertisement.address

        let url = URL(string: advertisement.imageURL)
        advertisementImageView.kf.setImage(with: url)
    }

    func showError(_ error: String) {

    }
}
