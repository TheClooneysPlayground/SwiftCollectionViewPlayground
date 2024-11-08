//
//  NativeButtonsCollectionView.swift
//  tvOSCollectionViewCompositionalLayout
//
//  Created by Nicholas Clooney on 1/10/2024.
//

import Foundation
import UIKit

class NativeButtonsCollectionView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a compositional layout
        let layout = createLayout()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .black
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "Cell")

        view.addSubview(collectionView)
    }

    func createLayout() -> UICollectionViewLayout {
        // Create a compositional layout
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        section.orthogonalScrollingBehavior = .continuous

        return UICollectionViewCompositionalLayout(section: section)
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 // Number of cells
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCell
        cell.button.setTitle("Button \(indexPath.item)", for: .normal)
        return cell
    }
}

// Custom cell with a button
private class CustomCell: UICollectionViewCell {
    let button: UIButton
    private let focusGuide = UIFocusGuide()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        super.init(frame: frame)

        // Set up the button
        button.addTarget(self, action: #selector(buttonTapped), for: .primaryActionTriggered)
        contentView.addSubview(button)

        // Constraints for button
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])

        // Add and configure the focus guide
        setupFocusGuide()
    }

    @objc func buttonTapped() {
        print("Button tapped!")
    }

    private func setupFocusGuide() {
         // Configure the focus guide
         contentView.addLayoutGuide(focusGuide)
         focusGuide.preferredFocusEnvironments = [button]

        focusGuide.leftAnchor.constraint(equalTo: button.leftAnchor).isActive = true
        focusGuide.topAnchor.constraint(equalTo: button.topAnchor).isActive = true
        focusGuide.widthAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        focusGuide.heightAnchor.constraint(equalTo: button.heightAnchor).isActive = true
    }

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
    }
}
