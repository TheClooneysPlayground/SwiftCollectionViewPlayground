//
//  ButtonCollectionView.swift
//  tvOSCollectionViewCompositionalLayout
//
//  Created by Nicholas Clooney on 27/9/2024.
//

import UIKit
import TVUIKit

class ButtonCollectionViewViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the UICollectionView
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            self.createLayout()
        }

        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)

        collectionView.register(ButtonCell.self, forCellWithReuseIdentifier: "cell")

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .black

        view.addSubview(collectionView)
    }


    private func createLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 40, leading: 40, bottom: 40, trailing: 40)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        // scroll horizontally
        section.orthogonalScrollingBehavior = .continuous

        return section
    }


    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 // Number of cells
    }

    // MARK: Helper Methods
    fileprivate func image(for indexPath: IndexPath) -> UIImage? {
        return UIImage(named: "A\(indexPath.row + 1)")
    }

    fileprivate func title(for indexPath: IndexPath) -> String {
        return "Pic #\(indexPath.row + 1)"
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ButtonCell
        cell.myButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .primaryActionTriggered)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! ButtonCell

        print("cell focusable", cell.canBecomeFocused)
        print("button focusable", cell.myButton.canBecomeFocused)
    }

    // MARK: - Button Action
    @objc func buttonTapped(_ sender: UIButton) {
        print("Button tapped!")
    }
}

