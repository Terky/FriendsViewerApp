//
//  FriendCell.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 11/3/20.
//

import UIKit

final class FriendCell: UICollectionViewCell, Cell {
    typealias ItemType = User

    private(set) lazy var avaterView: UIImageView = {
        let imageView = CircularImageView()

        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private(set) lazy var nameView: UILabel! = {
        let nameView = UILabel()

        nameView.translatesAutoresizingMaskIntoConstraints = false
        nameView.font = .preferredFont(forTextStyle: .title3)

        return nameView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(avaterView)
        contentView.addSubview(nameView)

        setupConstraints()
    }

    required init?(coder: NSCoder) {
        preconditionFailure("Not implemented")
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            avaterView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            avaterView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avaterView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            avaterView.widthAnchor.constraint(equalTo: avaterView.heightAnchor),

            nameView.leftAnchor.constraint(equalTo: avaterView.rightAnchor, constant: 10),
            nameView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(with item: User) {
        avaterView.loadImage(from: item.avatarURL)
        nameView.text = item.fullName
    }
}
