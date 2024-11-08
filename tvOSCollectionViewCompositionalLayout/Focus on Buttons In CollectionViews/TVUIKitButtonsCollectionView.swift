//
//  TVUIKitButtonsCollectionView.swift
//  tvOSCollectionViewCompositionalLayout
//
//  Created by Nicholas Clooney on 1/10/2024.
//

import Foundation
import UIKit
import TVUIKit

class TVUIKitButtonsCollectionView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let collectionView: UICollectionView
    let cellIdentifier = "Cell"

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        // Set up the layout for the collection view
        let layout = TVCollectionViewFullScreenLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the collection view
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: cellIdentifier)

        // Add collection view to the view hierarchy
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 // Number of cells
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CustomCell
        cell.button.setTitle("Button \(indexPath.item)", for: .normal)
        return cell
    }
}

// Custom cell with a button
private class CustomCell: TVCollectionViewFullScreenCell {
    let button: UIButton

    override init(frame: CGRect) {
        button = UIButton(type: .system)

        super.init(frame: frame)

        let contentView = maskedContentView

        // Set up the button
        button.addTarget(self, action: #selector(buttonTapped), for: .primaryActionTriggered)
        button.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(button)

        // Constraints for button
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func buttonTapped() {
        print("Button tapped!")
    }
}
