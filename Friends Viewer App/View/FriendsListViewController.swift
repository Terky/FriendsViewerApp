//
//  ListViewController.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 11/3/20.
//

import UIKit

final class FriendsListViewController: UIViewController, Storyboarded {
    var coordinator: UserCoordinator?

    var users: [User]? {
        didSet {
            if let users = users {
                updateDataSource(with: users)
            }
        }
    }

    private lazy var dataSource: UICollectionViewDiffableDataSource<Int, User> =
        UICollectionViewDiffableDataSource<Int, User>(
            collectionView: collectionView) { collectionView, indexPath, item in
            guard let cell = collectionView
                    .dequeueReusableCell(
                        withReuseIdentifier: FriendCell.identifier,
                        for: indexPath) as? FriendCell else {
                fatalError("Unable to dequeue \(FriendCell.identifier)")
            }

            cell.configure(with: item)

            return cell
        }

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())

        collectionView.backgroundColor = .systemBackground
        collectionView.register(FriendCell.self, forCellWithReuseIdentifier: FriendCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
    }

    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func createLayout() -> UICollectionViewLayout {
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

    private func updateDataSource(with items: [User]?) {
        guard let users = items else {
            return
        }

        var snapshot = NSDiffableDataSourceSnapshot<Int, User>()

        snapshot.appendSections([0])
        snapshot.appendItems(users)

        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension FriendsListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let user = users?[indexPath.item] {
            coordinator?.showUser(user: user)
        }
    }
}
