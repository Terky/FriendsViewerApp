//
//  MainCoordinator.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 10/29/20.
//

import UIKit

class MainCoordinator: Coordinator {
    private let authService = AuthenticationService()
    private let userService = UserService()
    private let friendsService = FriendsService()

    private(set) var navigationController: UINavigationController

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        if authService.token == nil {
            startLoginScreen()
        } else {
            startLoginScreen()
        }
    }

    func showUser(user: User) {
        let vc = UserViewController.instantiate()

        vc.coordinator = self
        vc.user = user

        friendsService.getFriends(token: authService.token, for: user) { friendsRes in
            DispatchQueue.main.async {
                switch friendsRes {
                    case .success(let friends):
                        vc.friendsVC.users = friends
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                }
            }
        }

        navigationController.pushViewController(vc, animated: true)
    }

    private func startLoginScreen() {
        let vc = LoginViewController.instantiate()
        navigationController.pushViewController(vc, animated: true)

        authService.authenticate(anchor: vc) { error in
            DispatchQueue.main.async {
                self.startUserScreen()
            }
        }
    }

    private func startUserScreen() {
        let vc = UserViewController.instantiate()

        vc.coordinator = self
        userService.getUser(for: authService.token) { res in
            DispatchQueue.main.async {
                switch res {
                case .success(let user):
                    vc.user = user
                    self.friendsService.getFriends(token: self.authService.token, for: user) { friendsRes in
                        DispatchQueue.main.async {
                            switch friendsRes {
                                case .success(let friends):
                                    vc.friendsVC.users = friends
                                case .failure(let error):
                                    fatalError(error.localizedDescription)
                            }
                        }
                    }
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }
            }
        }

        navigationController.setViewControllers([vc], animated: false)
    }
}

