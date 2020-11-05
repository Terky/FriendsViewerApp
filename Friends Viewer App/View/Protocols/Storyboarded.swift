//
//  Storyboarded.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 10/29/20.
//

import UIKit

protocol Storyboarded {}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let identifier = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: .main)

        return storyboard.instantiateViewController(identifier: identifier) as! Self
    }
}

