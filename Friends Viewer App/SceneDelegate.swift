//
//  SceneDelegate.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 10/29/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var coordinator: MainCoordinator?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }

        let window = UIWindow(windowScene: windowScene)
        self.window = window

        let navController = UINavigationController()
        let sceneCoordinator = MainCoordinator(navigationController: navController)
        coordinator = sceneCoordinator

        window.rootViewController = navController

        window.makeKeyAndVisible()
        sceneCoordinator.start()
    }

}
