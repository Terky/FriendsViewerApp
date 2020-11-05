//
//  UserError.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 10/30/20.
//

import Foundation

enum UserError: ServiceError {
    case userNotFound
    case internalError(description: String)
}
