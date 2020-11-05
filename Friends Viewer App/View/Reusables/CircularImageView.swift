//
//  CircularImageView.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 11/3/20.
//

import UIKit

class CircularImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
    }
}
