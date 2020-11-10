//
//  UserViewController.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 10/30/20.
//

import UIKit

final class UserViewController: UIViewController, Storyboarded {
    var coordinator: UserCoordinator?

    var user: User! {
        didSet {
            title = user.fullName
            avatarView.loadImage(from: user.avatarURL)
        }
    }

    // MARK: UI Setup

    lazy var friendsVC: FriendsListViewController = {
        let friendsVC = FriendsListViewController.instantiate()

        friendsVC.view.layer.zPosition = -1
        friendsVC.view.translatesAutoresizingMaskIntoConstraints = false
        friendsVC.view.frame = view.bounds

        return friendsVC
    }()

    private lazy var avatarView: UIImageView = {
        let imageView = CircularImageView()

        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always

        view.addSubview(avatarView)

        add(friendsVC)
        friendsVC.coordinator = coordinator
    }

    // MARK: Constraints

    private lazy var commonConstraint: [NSLayoutConstraint] = {
        let avatarViewSide = (isLandscape ? view.frame.size.height : view.frame.size.width) * 0.6
        let greaterSide = isLandscape ? view.frame.size.width : view.frame.size.height

        let constraints = [
            avatarView.widthAnchor.constraint(equalTo: avatarView.heightAnchor),
            avatarView.widthAnchor.constraint(equalToConstant: avatarViewSide)
        ]

        let constraint = friendsVC
            .view
            .widthAnchor
            .constraint(greaterThanOrEqualToConstant: greaterSide - 40 - avatarViewSide)
        constraint.priority = .defaultLow

        return constraints + [constraint]
    }()

    private lazy var portraitConstraints = [
        avatarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        avatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

        friendsVC.view.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 20),
        friendsVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        friendsVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        friendsVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ]

    private lazy var landscapeConstraints = [
        avatarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
        avatarView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

        friendsVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        friendsVC.view.leadingAnchor.constraint(greaterThanOrEqualTo: avatarView.trailingAnchor, constant: 20),
        friendsVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        friendsVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ]

    private var isLandscape: Bool {
        guard let scene = UIApplication
                .shared
                .windows
                .first(where: { $0.isKeyWindow })?
                .windowScene else {
            fatalError("No scene connected")
        }

        let orientation = scene.interfaceOrientation

        return orientation == .landscapeRight || orientation == .landscapeLeft
    }

    private func setupConstraints() {
        if !commonConstraint[0].isActive {
            NSLayoutConstraint.activate(commonConstraint)
        }

        if isLandscape {
            NSLayoutConstraint.deactivate(portraitConstraints)
            NSLayoutConstraint.activate(landscapeConstraints)
        } else {
            NSLayoutConstraint.deactivate(landscapeConstraints)
            NSLayoutConstraint.activate(portraitConstraints)
        }
    }

    // MARK: View Lifecycle and Events

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        setupConstraints()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { _ in
            self.setupConstraints()
        })
    }
}
