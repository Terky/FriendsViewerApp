//
//  AuthenticationCoordinator.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 11/8/20.
//

import UIKit
import AuthenticationServices

final class LoginCoordinator: Coordinator {
    var parent: MainCoordinator
    var authService: AuthenticationService
    var navigationController: UINavigationController

    init(navigationController: UINavigationController, parent: MainCoordinator, authService: AuthenticationService) {
        self.navigationController = navigationController
        self.parent = parent
        self.authService = authService
    }

    func start() {
        let loginVC = LoginViewController.instantiate()
        loginVC.coordinator = self
        navigationController.pushViewController(loginVC, animated: true)

        startAuthenticationSession(for: loginVC)
    }

    func startAuthenticationSession(for anchor: ASWebAuthenticationPresentationContextProviding) {
        authService.authenticate(anchor: anchor) { error in
            guard error == nil else {
//                fatalError(error.debugDescription)
                return
            }

            self.parent.didFinishLogin()
        }
    }
}
