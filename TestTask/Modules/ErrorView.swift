//
//  ErrorView.swift
//  TestTask
//
//  Created by Daniil Chemaev on 30.08.2023.
//

import UIKit

// A custom view to display error messages and provide a retry button.
class ErrorView: UIView {

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Повторить", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // A closure that will be called when the retry button is tapped.
    var onRetryButtonTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }

    private func setupSubviews() {
        addSubview(messageLabel)
        addSubview(retryButton)

        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            retryButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
            retryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            retryButton.widthAnchor.constraint(equalToConstant: 120),
            retryButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        retryButton.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
    }

    @objc private func retryButtonTapped() {
        onRetryButtonTapped?()
    }

    // Configures the view with an error message.
    func configure(message: String) {
        messageLabel.text = message
    }
}
