//
//  Response.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 10/31/20.
//

import Foundation

struct Response<T: Codable>: Codable {
    let response: T

    static func decode(from data: Data) -> T? {
        try? JSONDecoder().decode(self.self, from: data).response
    }
}
