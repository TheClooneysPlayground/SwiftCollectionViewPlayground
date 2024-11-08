/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A list with inset item content described by compositional layout
*/

import UIKit

class InsetItemsGridViewController: UIViewController {

    enum Section {
        case main
    }

//    var dataSource: UICollectionViewDiffableDataSource<Int, Int>! = nil
    var collectionView: UICollectionView! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Inset Items Grid"

        configureHierarchy()
        configureDataSource()
        configureCollectionView()
    }
}

extension InsetItemsGridViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        5
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: TextCell.reuseIdentifier, for: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        collectionView.dequeueReusableSupplementaryView(
            ofKind: Element.header.rawValue,
            withReuseIdentifier: TitleSupplementaryView.reuseIdentifier,
            for: indexPath
        )
    }

    //

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? TextCell else {
            fatalError()
        }

        let number = indexPath.section * 10 + indexPath.row

        cell.label.setTitle("\(number)", for: .normal)
        cell.contentView.backgroundColor = .cornflowerBlue
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.label.titleLabel!.textAlignment = .center
        cell.label.titleLabel!.font = UIFont.preferredFont(forTextStyle: .title1)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        guard let view = view as? TitleSupplementaryView else {
            fatalError()
        }

        view.label.text = "Test"
    }
}

/// Data & Loading
extension InsetItemsGridViewController {
//    func loadData(into dateSource: UICollectionViewDiffableDataSource<Int, Int>) {
//        dataSource.apply(
////            oneSectionSnapshot(),
//             twoSectionsSnapshot(),
//            animatingDifferences: false
//        )
//    }
//
//    func twoSectionsSnapshot() -> NSDiffableDataSourceSnapshot<Int, Int> {
//        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
//
//        snapshot.appendSections([1])
//        snapshot.appendItems(Array(0...14))
//        snapshot.appendSections([2])
//        snapshot.appendItems(Array(15...19))
//        snapshot.appendSections([3])
//        snapshot.appendItems(Array(20...24))
//        snapshot.appendSections([4])
//        snapshot.appendItems(Array(25...29))
//
//        return snapshot
//    }
//
//    func oneSectionSnapshot() -> NSDiffableDataSourceSnapshot<Int, Int> {
//        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
//
//        snapshot.appendSections([1])
//        snapshot.appendItems(Array(0...99))
//
//        return snapshot
//    }
}

/// Layout
extension InsetItemsGridViewController {

    /// - Tag: Inset
    func createLayout() -> UICollectionViewLayout {
        oneRowLayout()
    }

    /// doesn't work
    func twoRowsLayoutV2() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let inset: CGFloat = 35
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.5))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     repeatingSubitem: item,
                                                     count: 2)

        group.interItemSpacing = .fixed(10)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        // scroll horizontally
        section.orthogonalScrollingBehavior = .groupPaging

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    /// doesn't work
    func twoRowsLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let inset: CGFloat = 35
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])


        let section = NSCollectionLayoutSection(group: group)


        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    func oneRowLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalWidth(0.2))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])

            let section = NSCollectionLayoutSection(group: group)

            // scroll horizontally
            section.orthogonalScrollingBehavior = .groupPaging

            // Sections

            let headerFooterSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(44)
            )
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerFooterSize,
                elementKind: Element.header.rawValue,
                alignment: .topLeading
            )

            section.boundarySupplementaryItems = [sectionHeader]


            return section
        }

    }

    private enum Element: String {
        case header
    }
}

extension InsetItemsGridViewController {
    func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .black

        collectionView.remembersLastFocusedIndexPath = true

        view.addSubview(collectionView)
    }

    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(TextCell.self, forCellWithReuseIdentifier: TextCell.reuseIdentifier)
        collectionView.register(
            TitleSupplementaryView.self,
            forSupplementaryViewOfKind: Element.header.rawValue,
            withReuseIdentifier: TitleSupplementaryView.reuseIdentifier
        )
    }

    func configureDataSource() {
//        let cellRegistration = UICollectionView.CellRegistration<TextCell, Int> { (cell, indexPath, identifier) in
//            // Populate the cell with our item description.
//            cell.label.setTitle("\(identifier)", for: .normal)
//            cell.contentView.backgroundColor = .cornflowerBlue
//            cell.layer.borderColor = UIColor.black.cgColor
//            cell.layer.borderWidth = 1
//            cell.label.titleLabel!.textAlignment = .center
//            cell.label.titleLabel!.font = UIFont.preferredFont(forTextStyle: .title1)
//        }
//
//        dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) {
//            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
//            // Return the cell.
//            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
//        }
//
//        let supplementaryRegistration = UICollectionView.SupplementaryRegistration
//        <TitleSupplementaryView>(elementKind: Element.header.rawValue) {
//            (supplementaryView, string, indexPath) in
//            supplementaryView.label.text = "Test"
//        }
//
//        dataSource.supplementaryViewProvider = { (view, kind, index) in
//            return self.collectionView.dequeueConfiguredReusableSupplementary(
//                using: supplementaryRegistration, for: index)
//        }
//
//
//        loadData(into: dataSource)
    }
}

class TitleSupplementaryView: UICollectionReusableView {
    let label = UILabel()
    static let reuseIdentifier = "title-supplementary-reuse-identifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension TitleSupplementaryView {
    func configure() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        let inset = CGFloat(10)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            label.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset)
        ])
        label.font = UIFont.preferredFont(forTextStyle: .title3)
    }
}
