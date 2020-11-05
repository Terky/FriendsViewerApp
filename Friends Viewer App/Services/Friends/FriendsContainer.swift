//
//  FriendsContainer.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 11/5/20.
//

import Foundation

struct FriendsContainer: Codable {
    let count: Int
    let items: [User]
}
