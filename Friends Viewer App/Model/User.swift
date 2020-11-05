//
//  User.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 10/30/20.
//

import Foundation

public struct User: Codable, Hashable {
    public let id: Int
    public let firstName: String
    public let lastName: String
    public let avatarURL: URL

    public var fullName: String {
        "\(firstName) \(lastName)"
    }
}

extension User {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case avatarURL = "photo_max"
    }
}
