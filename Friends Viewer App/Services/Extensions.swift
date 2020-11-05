//
//  Extensions.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 10/29/20.
//

import Foundation

extension URL {
    init(staticString string: StaticString) {
        guard let url = URL(string: "\(string)") else {
            preconditionFailure("Invalid static URL string: \(string)")
        }

        self = url
    }
}
