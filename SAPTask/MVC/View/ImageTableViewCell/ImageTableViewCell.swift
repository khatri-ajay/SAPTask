//
//  ImageTableViewCell.swift
//  SAPTask
//
//  Created by Ajay Kumar on 04/02/2022.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    let image: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Adding UI object to view
extension ImageTableViewCell{
    private func setupViews() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 5
        contentView.backgroundColor = .systemGray5
        image.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(image)
    }
}
// MARK: - Adding Constraints
extension ImageTableViewCell{
    private func setupLayouts() {
        // ImageView Constraints
        image.layer.cornerRadius = 2
        image.clipsToBounds = true
        image.applyConstraints(
            .top(to: contentView.topAnchor, constant: 5),
            .bottom(to: contentView.bottomAnchor, constant: -5),
            .leading(to: contentView.leadingAnchor, constant: 5),
            .trailing(to: contentView.trailingAnchor, constant: -5),
            .height(constant: 400))
    }
}
// MARK: - Setup Cell With data
extension ImageTableViewCell{
    func setup(model: Photo) {
        let url = ImageModel.createImageUrl(model: model)
        image.load.request(with: url)
    }
}

