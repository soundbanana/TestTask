//
//  CatalogCollectionViewCell.swift
//  TestTask
//
//  Created by Daniil Chemaev on 26.08.2023.
//

import UIKit
import Kingfisher

class CatalogCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "CatalogCollectionViewCell"

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
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var createdDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray
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
        contentView.backgroundColor = .white
        contentView.addSubviews(advertisementImage, titleLabel, priceLabel, locationLabel, createdDateLabel)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            advertisementImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            advertisementImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            advertisementImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            advertisementImage.heightAnchor.constraint(equalToConstant: 150),

            titleLabel.topAnchor.constraint(equalTo: advertisementImage.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            locationLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 4),
            locationLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: priceLabel.trailingAnchor),

            createdDateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 4),
            createdDateLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            createdDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func configure(with advertisement: Advertisement) {
        titleLabel.text = advertisement.title
        priceLabel.text = advertisement.price
        locationLabel.text = advertisement.location
        createdDateLabel.text = advertisement.createdDate

        let url = URL(string: advertisement.imageURL)
        advertisementImage.kf.setImage(with: url)
    }
}

