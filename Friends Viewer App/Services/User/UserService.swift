//
//  UserService.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 10/30/20.
//

import Foundation

final class UserService {
    weak var authService: AuthenticationService!

    init(authService: AuthenticationService) {
        self.authService = authService
    }

    func getUser(id userId: String? = nil, then handler: ((Result<User, NetworkError>) -> Void)?) {
        var endpoint = Endpoint.getUser(token: authService.token)

        if let userId = userId {
            endpoint = endpoint.appending(queryItem: URLQueryItem(name: "user_ids", value: userId))
        }

        DataLoader.request(endpoint) { (loadingResult: Result<Data, NetworkError>) -> Void in
            let result: Result<User, NetworkError>

            switch loadingResult {
            case .failure(let error):
                result = .failure(error)
            case .success(let data):
                if let user = Response<[User]>.decode(from: data)?.first {
                    result = .success(user)
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
    fileprivate static func getUser(token: String) -> Endpoint {
        Endpoint(
            scheme: "https",
            host: "api.vk.com",
            path: UserConstants.getMethod,
            queryItems: [
                URLQueryItem(name: "access_token", value: token),
                URLQueryItem(name: "fields", value: "photo_max")
            ])
    }
}
