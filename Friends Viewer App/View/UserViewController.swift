//
//  UserViewController.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 10/30/20.
//

import UIKit

class UserViewController: UIViewController, Storyboarded {
    var coordinator: MainCoordinator?

    var user: User! = nil {
        didSet {
            if let user = user {
                title = user.fullName
                avatarView.loadImage(from: user.avatarURL)
                loadingComplete()
            } else {
                showLoading()
            }
        }
    }

    var loadingVC: LoadingViewController?
    var friendsVC: FriendsListViewController!
    private lazy var avatarView: UIImageView = {
        let imageView = CircularImageView(
            frame: CGRect(origin: .zero, size: CGSize(width: 250, height: 250)))

        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private lazy var defaultConstraints = [
        avatarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        avatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        avatarView.widthAnchor.constraint(equalTo: avatarView.heightAnchor),

        friendsVC.view.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 20),
        friendsVC.view.leftAnchor.constraint(equalTo: view.leftAnchor),
        friendsVC.view.rightAnchor.constraint(equalTo: view.rightAnchor),
        friendsVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ]

    private lazy var phoneLandscapeConstraints = [
        avatarView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
        avatarView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        avatarView.widthAnchor.constraint(equalTo: avatarView.heightAnchor),

        friendsVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        friendsVC.view.leftAnchor.constraint(equalTo: avatarView.rightAnchor, constant: 20),
        friendsVC.view.rightAnchor.constraint(equalTo: view.rightAnchor),
        friendsVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ]

    private var phoneLandscape: Bool {
        view.traitCollection.verticalSizeClass == .compact
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always

        view.addSubview(avatarView)

        friendsVC = FriendsListViewController.instantiate()
        add(friendsVC)
        friendsVC.view.layer.zPosition = -1
        friendsVC.view.translatesAutoresizingMaskIntoConstraints = false
        friendsVC.coordinator = coordinator

        setupConstraints()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        setupConstraints()
    }

    private func setupConstraints() {
        if phoneLandscape {
            NSLayoutConstraint.deactivate(defaultConstraints)
            NSLayoutConstraint.activate(phoneLandscapeConstraints)
        } else {
            NSLayoutConstraint.deactivate(phoneLandscapeConstraints)
            NSLayoutConstraint.activate(defaultConstraints)
        }
    }

    private func showLoading() {
        loadingVC = LoadingViewController()
        loadingVC!.view.frame = avatarView.bounds
        add(loadingVC!)
    }

    private func loadingComplete() {
        loadingVC?.remove()
        loadingVC = nil
    }
}
