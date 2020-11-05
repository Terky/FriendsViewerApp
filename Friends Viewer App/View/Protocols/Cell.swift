//
//  Cell.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 11/3/20.
//

import UIKit

protocol Cell: UICollectionViewCell {
    associatedtype ItemType

    func configure(with item: ItemType)
}

extension Cell {
    static var identifier: String {
        String(describing: self)
    }
}
