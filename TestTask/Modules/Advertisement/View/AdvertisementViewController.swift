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

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
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

    private lazy var createdDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
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
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
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
            advertisementImageView.heightAnchor.constraint(equalToConstant: 350),

            titleLabel.topAnchor.constraint(equalTo: advertisementImageView.bottomAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),

            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding / 2),
            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),

            locationLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: padding / 4),
            locationLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor),

            createdDateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: padding / 4),
            createdDateLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: createdDateLabel.bottomAnchor, constant: padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),

            emailLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: padding),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),

            phoneNumberLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: padding / 4),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),

            addressLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: padding / 4),
            addressLabel.leadingAnchor.constraint(equalTo: phoneNumberLabel.leadingAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: phoneNumberLabel.trailingAnchor),
            addressLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding)
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
