//
//  ViewControllerExtenstion.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 11/4/20.
//

import UIKit

@nonobjc extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
