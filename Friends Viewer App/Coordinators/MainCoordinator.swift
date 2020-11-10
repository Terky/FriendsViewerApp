//
//  MainCoordinator.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 10/29/20.
//

import UIKit

final class MainCoordinator: Coordinator {
    // MARK: App Dependencies

    private lazy var authService = AuthenticationService()
    private lazy var userService = UserService(authService: authService)
    private lazy var friendsService = FriendsService(authService: authService)

    private(set) var navigationController: UINavigationController

    private var childCoordinators = [Coordinator]()

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        if authService.token == nil {
            startLoginScreen()
        } else {
            startUserScreen()
        }
    }

    func startLoginScreen() {
        childCoordinators.append(
            LoginCoordinator(navigationController: navigationController,
                             parent: self,
                             authService: authService))

        childCoordinators.last?.start()
    }

    func didFinishLogin() {
        childCoordinators.removeLast()
        startUserScreen()
    }

    func startUserScreen() {
        childCoordinators.append(
            UserCoordinator(navigationController: navigationController,
                            parent: self,
                            userService: userService,
                            friendsService: friendsService))

        childCoordinators.last?.start()
    }
}
