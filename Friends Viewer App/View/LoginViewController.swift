//
//  LoginViewController.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 10/29/20.
//

import UIKit
import AuthenticationServices

class LoginViewController: UIViewController, Storyboarded {
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
}

extension LoginViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return self.view.window ?? ASPresentationAnchor()
    }
}
