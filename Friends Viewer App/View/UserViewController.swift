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
                loadingVC?.remove()
                loadingVC = nil
            } else {
                loadingVC = LoadingViewController()
                loadingVC!.view.frame = avatarView.bounds
                add(loadingVC!)
            }
        }
    }

    var loadingVC: LoadingViewController?
    var friendsVC: FriendsListViewController!
    private lazy var avatarView = setupAvatarView()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always

        view.addSubview(avatarView)

        friendsVC = FriendsListViewController.instantiate()
        add(friendsVC)
        friendsVC.view.translatesAutoresizingMaskIntoConstraints = false
        friendsVC.coordinator = coordinator

        setupConstraints()
    }

    func setupAvatarView() -> UIImageView {
        let imageView = CircularImageView(
            frame: CGRect(origin: .zero, size: CGSize(width: 250, height: 250)))

        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            avatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarView.widthAnchor.constraint(equalTo: avatarView.heightAnchor),

            friendsVC.view.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 20),
            friendsVC.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            friendsVC.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            friendsVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
