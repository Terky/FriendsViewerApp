//
//  Endpoint.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 10/29/20.
//

import Foundation

struct Endpoint {
    let scheme: String
    let host: String
    let path: String
    let queryItems: [URLQueryItem]
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        components.queryItems?.append(URLQueryItem(name: "v", value: "5.124"))

        return components.url
    }
}
