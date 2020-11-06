//
//  AuthenticationService.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 10/29/20.
//

import Foundation
import AuthenticationServices

class AuthenticationService {
    public private(set) var session: ASWebAuthenticationSession?

    public private(set) var token: String!

    public func authenticate(anchor vc: ASWebAuthenticationPresentationContextProviding, then handler: ((NetworkError?) -> Void)?) {
        guard let authURL = Endpoint.auth().url else {
            handler?(.invalidUrl)
            return
        }

        session = ASWebAuthenticationSession(url: authURL, callbackURLScheme: AuthConstants.callbackURI) {
            [weak self] (callBack: URL?, error: Error?) in
            var resultError: NetworkError? = nil

            defer {
                DispatchQueue.main.async {
                    handler?(resultError)
                }
            }

            guard error == nil, let successURL = callBack else {
                resultError = .loadingError(error!)
                return
            }

            self?.token = self?.extractToken(from: successURL)
        }

//        session?.prefersEphemeralWebBrowserSession = true
        session?.presentationContextProvider = vc
        session?.start()
    }

    private func extractToken(from url: URL) -> String? {
        let inputComponents = URLComponents(string: url.absoluteString)
        var components = URLComponents()
        components.query = inputComponents?.fragment

        return components
            .queryItems?
            .first(where: { $0.name == "access_token" })?
            .value
    }
}
