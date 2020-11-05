//
//  NetworkError.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 10/30/20.
//

import Foundation

enum NetworkError: ServiceError {
    case invalidUrl
    case invalidDataFormat
    case loadingError(Error)
}
