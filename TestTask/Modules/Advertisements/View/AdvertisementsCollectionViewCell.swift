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
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .label
        label.numberOfLines = 2
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()

    private lazy var placeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()

    private lazy var publishedAtLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()

    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        return button
    }()

    private lazy var optionButton: UIButton = {
        let button = UIButton()
        return button
    }()

    private lazy var actionStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()

//    func configure(with advertisement: AdvertisementPreview) {
//        self.advertisement = advertisement
//
//        nameLabel.text = advertisement.title
//        placeLabel.text = advertisement.location
//        priceLabel.text = advertisement.price
//    }
}

