//
//  ImageCell.swift
//  tvOSCollectionViewCompositionalLayout
//
//  Created by Nicholas Clooney on 9/9/2024.
//

import UIKit

class ImageCell: UICollectionViewCell {
    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        contentView.addSubview(imageView)

        imageView.clipsToBounds = false
        imageView.contentMode = .scaleAspectFill

        // Motion Effect on tvOS when focused
        imageView.adjustsImageWhenAncestorFocused = true


        // Set up constraints
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    func configure(with image: UIImage?) {
        imageView.image = image
    }
}
