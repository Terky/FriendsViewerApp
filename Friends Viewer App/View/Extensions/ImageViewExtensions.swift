//
//  ImageViewExtenstions.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 10/31/20.
//

import UIKit

extension UIImageView {
    fileprivate static var stub: UIImage {
        UIImage(systemName: "xmark.circle")!
    }

    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil, let data = data else {
                self.setImage(UIImageView.stub)
                return
            }

            guard let image = UIImage(data: data) else {
                self.setImage(UIImageView.stub)
                return
            }

            self.setImage(image)
        }.resume()
    }

    fileprivate func setImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.image = image
        }
    }
}
