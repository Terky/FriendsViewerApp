//
//  Coordinator.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 10/29/20.
//

import UIKit

protocol Coordinator: class {
    var navigationController: UINavigationController { get }

    func start()
}
