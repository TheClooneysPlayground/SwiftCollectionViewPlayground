//
//  GridImageCompositionalCollectionViewController.swift
//  tvOSCollectionViewCompositionalLayout
//
//  Created by Nicholas Clooney on 9/9/2024.
//

import UIKit

/// Show case Compositional Layout & `UIImageView.adjustsImageWhenAncestorFocused`
/// Note: Images are downloaded royalty free from https://www.pexels.com/.
class GridImageCompositionalCollectionViewController:
    UIViewController,
    UICollectionViewDataSource,
    UICollectionViewDelegate
{

    private var collectionView: UICollectionView!

    private let images = (1...10)
        .map { "A\($0)" }
        .map { UIImage(named: $0) }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the UICollectionView
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            return self.createLayout()
        }
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .black

        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")

        view.addSubview(collectionView)

        // Set up constraints for the collection view
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func createLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 40, leading: 40, bottom: 40, trailing: 40)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.7))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        return section
    }

    // UICollectionViewDataSource Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ImageCell else {
            fatalError("Something doesn't add up...")
        }

        // Configure the cell
        let image = images[indexPath.item]

        cell.configure(with: image)
    }
}

