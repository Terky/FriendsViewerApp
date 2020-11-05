//
//  UserService.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 10/30/20.
//

import Foundation

final class UserService {
    func getUser(for token: String, then handler: @escaping (Result<User, UserError>) -> Void) {
        let endpoint = Endpoint.getUser(token: token)

        DataLoader.request(endpoint) { (loadingResult: Result<Data, NetworkError>) -> Void in
            let result: Result<User, UserError>

            switch loadingResult {
                case .failure(let error):
                    result = .failure(.internalError(description: error.localizedDescription))
                case .success(let data):
                    if let user = try? JSONDecoder().decode(Response<[User]>.self, from: data).response.first {
                        result = .success(user)
                    } else {
                        result = .failure(.userNotFound)
                    }
            }

            handler(result)
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
