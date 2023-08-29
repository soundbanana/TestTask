//
//  AdvertisementsCollectionViewCell.swift
//  TestTask
//
//  Created by Daniil Chemaev on 26.08.2023.
//

import UIKit

class AdvertisementsCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "AdvertisementsCollectionViewCell"

    private lazy var advertisementImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person"))
        imageView.layer.cornerRadius = 6
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .label
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var createdDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI() {
        contentView.backgroundColor = .red
        contentView.addSubview(advertisementImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(createdDateLabel)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            advertisementImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            advertisementImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            advertisementImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            advertisementImage.heightAnchor.constraint(equalToConstant: 150),
            advertisementImage.widthAnchor.constraint(equalToConstant: 150),

            titleLabel.topAnchor.constraint(equalTo: advertisementImage.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            locationLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: priceLabel.trailingAnchor),

            createdDateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor),
            createdDateLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            createdDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    func configure(with item: Advertisement) {
        titleLabel.text = item.title
        priceLabel.text = item.price
        locationLabel.text = item.location
        createdDateLabel.text = item.createdDate
    }
}

