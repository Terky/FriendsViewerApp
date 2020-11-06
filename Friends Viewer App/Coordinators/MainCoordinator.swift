//
//  MainCoordinator.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 10/29/20.
//

import UIKit

class MainCoordinator: Coordinator {
    private lazy var authService = AuthenticationService()
    private lazy var userService = UserService(authService: authService)
    private lazy var friendsService = FriendsService(authService: authService)

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

        friendsService.getFriends(for: user) { friendsRes in
            switch friendsRes {
                case .success(let friends):
                    vc.friendsVC.users = friends
                case .failure(let error):
                    fatalError(error.localizedDescription)
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
        func unwrapResult<T>(input: Result<T, NetworkError>, then handler: ((T) -> Void)?) {
            switch input {
            case .success(let result):
                handler?(result)
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }

        let vc = UserViewController.instantiate()

        vc.coordinator = self

        navigationController.setViewControllers([vc], animated: false)

        let job = userService.getUser >>>> unwrapResult >>>> { vc.user = $0; $1?($0) } >>>> friendsService.getFriends >>>> unwrapResult

//        userService.getUser { res in
//            if case .success(let user) = res {
//                vc.user = user
//                self.friendsService.getFriends(for: user) { friendsRes in
//                    if case .success(let friends) = friendsRes {
//                        vc.friendsVC.users = friends
//                    } else if case .failure(let error) = friendsRes {
//                        fatalError(error.localizedDescription)
//                    }
//                }
//            } else if case .failure(let error) = res {
//                fatalError(error.localizedDescription)
//            }
//        }
        job?(nil) { result in
            vc.friendsVC.users = result
        }
    }
}

