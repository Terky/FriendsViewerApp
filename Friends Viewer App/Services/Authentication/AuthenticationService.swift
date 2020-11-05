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

    public func authenticate(anchor vc: ASWebAuthenticationPresentationContextProviding, then handler: @escaping (Error?) -> Void) {
        guard let authURL = Endpoint.auth().url else { fatalError("Invalid URL") }

        session = ASWebAuthenticationSession.init(
            url: authURL,
            callbackURLScheme: AuthConstants.callbackURI,
            completionHandler: { [weak self] (callBack: URL?, error: Error?) in
                defer {
                    handler(error)
                }

                guard error == nil, let successURL = callBack else {
                    print(error!.localizedDescription)
                    return
                }

                let successURLComponents = URLComponents(string: successURL.absoluteString)
                var components = URLComponents()
                components.query = successURLComponents?.fragment

                self?.token = components
                    .queryItems?
                    .first(where: { $0.name == "access_token" })?
                    .value
            })

        session?.presentationContextProvider = vc
        session?.start()
    }
}
