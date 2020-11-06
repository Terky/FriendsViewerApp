//
//  DataLoader.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 10/30/20.
//

import Foundation

struct DataLoader {
    static func request(_ endpoint: Endpoint,
                        then handler: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = endpoint.url else {
            handler(.failure(.invalidUrl))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            defer {
                handler(result)
            }

            let result: Result<Data, NetworkError>

            guard error == nil, let data = data else {
                result = .failure(.loadingError(error!))
                return
            }

            result = .success(data)
        }

        task.resume()
    }
}
