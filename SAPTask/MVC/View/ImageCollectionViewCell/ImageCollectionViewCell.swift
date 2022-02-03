//
//  ImageCollectionViewCell.swift
//  SAPTask
//
//  Created by Ajay Kumar on 03/02/2022.
//

import UIKit
import ImageLoader


class ImageCollectionViewCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - Adding UI object to view
extension ImageCollectionViewCell{
    private func setupViews() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 5
        contentView.backgroundColor = .systemGray5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
    }
}
// MARK: - Adding Constraints
extension ImageCollectionViewCell{
    private func setupLayouts() {
        // ImageView Constraints
        imageView.layer.cornerRadius = 2
        imageView.clipsToBounds = true
        imageView.applyConstraints(
            .top(to: contentView.topAnchor, constant: 5),
            .bottom(to: contentView.bottomAnchor, constant: -5),
            .leading(to: contentView.leadingAnchor, constant: 5),
            .trailing(to: contentView.trailingAnchor, constant: -5))
    }
}
// MARK: - Setup Cell With data
extension ImageCollectionViewCell{
    func setup(model: Photo) {
        let url = ImageModel.createImageUrl(model: model)
        imageView.load.request(with: url)
    }
}
