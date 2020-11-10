//
//  UserCoordinator.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 11/8/20.
//

import UIKit

final class UserCoordinator: Coordinator {
    var userService: UserService
    var friendsService: FriendsService

    var parent: MainCoordinator
    var navigationController: UINavigationController

    init(navigationController: UINavigationController,
         parent: MainCoordinator,
         userService: UserService,
         friendsService: FriendsService) {
        self.navigationController = navigationController
        self.parent = parent
        self.userService = userService
        self.friendsService = friendsService
    }

    func start() {
        showUser(user: nil)
    }

    func showUser(user: User?) {
        let userVC = UserViewController.instantiate()
        userVC.coordinator = self

        let finalJobHandler = { friends in
            userVC.friendsVC.users = friends
        }

        if let user = user {
            navigationController.pushViewController(userVC, animated: true)
            userVC.user = user
            (friendsService.getFriends >>>> unwrapResult)?(user, finalJobHandler)
        } else {
            navigationController.setViewControllers([userVC], animated: false)
            (userService.getUser >>>>
                unwrapResult >>>>
                { userVC.user = $0; $1?($0) } >>>>
                friendsService.getFriends >>>>
                unwrapResult)?(nil, finalJobHandler)
        }
    }
}

extension UserCoordinator {
    // MARK: Utilities
    private func unwrapResult<T>(input: Result<T, NetworkError>, then handler: ((T) -> Void)?) {
        switch input {
        case .success(let result):
            handler?(result)
        case .failure(let error):
            fatalError(error.localizedDescription)
        }
    }
}
