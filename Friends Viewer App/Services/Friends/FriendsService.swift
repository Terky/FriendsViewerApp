//
//  FriendsService.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 10/30/20.
//

import Foundation

final class FriendsService {
    weak var authService: AuthenticationService!

    init(authService: AuthenticationService) {
        self.authService = authService
    }

    func getFriends(for user: User, then handler: ((Result<[User], NetworkError>) -> Void)?) {
        let endpoint = Endpoint.getFriends(token: authService.token, for: "\(user.id)")

        DataLoader.request(endpoint) { (loadingResult: Result<Data, NetworkError>) -> Void in
            let result: Result<[User], NetworkError>

            switch loadingResult {
            case .failure(let error):
                result = .failure(error)
            case .success(let data):
                if let users = Response<FriendsContainer>.decode(from: data)?.items {
                    result = .success(users)
                } else {
                    result = .failure(.invalidDataFormat)
                }
            }

            DispatchQueue.main.async {
                handler?(result)
            }
        }
    }
}

extension Endpoint {
    fileprivate static func getFriends(token: String, for userId: String) -> Endpoint {
        Endpoint(
            scheme: "https",
            host: "api.vk.com",
            path: FriendsConstants.getMethod,
            queryItems: [
                URLQueryItem(name: "user_id", value: userId),
                URLQueryItem(name: "order", value: "name"),
                URLQueryItem(name: "access_token", value: token),
                URLQueryItem(name: "fields", value: "photo_max")
            ])
    }
}
