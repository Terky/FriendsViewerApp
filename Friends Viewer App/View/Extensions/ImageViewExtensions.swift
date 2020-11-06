//
//  ImageViewExtenstions.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 10/31/20.
//

import UIKit

extension UIImageView {
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else {
                self.image = UIImage(systemName: "xmark.circle")
                return
            }

            guard let image = UIImage(data: data) else {
                self.image = UIImage(systemName: "xmark.circle")
                return
            }

            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
