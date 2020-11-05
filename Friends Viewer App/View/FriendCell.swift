//
//  FriendCell.swift
//  Friends Viewer App
//
//  Created by Artem Burmistrov on 11/3/20.
//

import UIKit

final class FriendCell: UICollectionViewCell, Cell {
    typealias ItemType = User

    private(set) var avaterView: UIImageView!
    private(set) var nameView: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        avaterView = createAvatarView()
        nameView = createNameView()

        contentView.addSubview(avaterView)
        contentView.addSubview(nameView)

        setupConstraints()
    }

    required init?(coder: NSCoder) {
        preconditionFailure("Not implemented")
    }

    func createAvatarView() -> UIImageView {
        let imageView = CircularImageView()

        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }

    func createNameView() -> UILabel {
        let nameView = UILabel()

        nameView.translatesAutoresizingMaskIntoConstraints = false
        nameView.font = .preferredFont(forTextStyle: .title3)

        return nameView
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Avatar constraints
            avaterView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            avaterView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avaterView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            avaterView.widthAnchor.constraint(equalTo: avaterView.heightAnchor),

            // Name constraints
            nameView.leftAnchor.constraint(equalTo: avaterView.rightAnchor, constant: 10),
            nameView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(with item: User) {
        avaterView.loadImage(from: item.avatarURL)
        nameView.text = item.fullName
    }
}
