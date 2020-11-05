//
//  AuthEndpoint.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 10/30/20.
//

import Foundation

extension Endpoint {
    static func auth() -> Endpoint {
        Endpoint(
            scheme: "https",
            host: "oauth.vk.com",
            path: "/authorize",
            queryItems: [
                URLQueryItem(name: "client_id", value: AuthConstants.appId),
                URLQueryItem(name: "redirect_uri", value: AuthConstants.callbackURI),
                URLQueryItem(name: "display", value: "mobile"),
                URLQueryItem(name: "scope", value: "offline+friends"),
                URLQueryItem(name: "response_type", value: "token"),
                URLQueryItem(name: "revoke", value: "1")
            ]
        )
    }
}

