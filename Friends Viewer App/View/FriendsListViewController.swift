//
//  ListViewController.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 11/3/20.
//

import UIKit

class FriendsListViewController: UIViewController, Storyboarded {
    var coordinator: MainCoordinator?

    var users: [User]? {
        didSet {
            updateDataSource(with: users)
        }
    }

    var collectionView: UICollectionView!

    var dataSource: UICollectionViewDiffableDataSource<Int, User>?

    override func viewDidLoad() {
        super.viewDidLoad()

        createHierarcy()
        createDataSource()

        updateDataSource(with: users)
    }

    func createHierarcy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: FriendsListViewController.createLayout())

        collectionView.backgroundColor = .systemBackground
        collectionView.register(FriendCell.self, forCellWithReuseIdentifier: FriendCell.identifier)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self

        view.addSubview(collectionView)
    }

    static func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, User>(collectionView: collectionView) {
               collectionView, indexPath, item in
               let cell = collectionView
                   .dequeueReusableCell(
                       withReuseIdentifier: FriendCell.identifier,
                       for: indexPath) as! FriendCell

               cell.configure(with: item)

               return cell
           }
    }

    func updateDataSource(with items: [User]?) {
        guard let users = items else {
            return
        }

        var snapshot = NSDiffableDataSourceSnapshot<Int, User>()

        snapshot.appendSections([0])
        snapshot.appendItems(users)

        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

extension FriendsListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let user = users?[indexPath.item] {
            coordinator?.showUser(user: user)
        }
    }
}
