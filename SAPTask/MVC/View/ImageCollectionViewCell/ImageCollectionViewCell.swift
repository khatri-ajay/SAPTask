//
//  ImageCollectionViewCell.swift
//  SAPTask
//
//  Created by Ajay Kumar on 03/02/2022.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()
    init() {
        super.init(frame: .zero)
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
        //constraints for `Fav Movie image`
        imageView.layer.cornerRadius = 2
        imageView.clipsToBounds = true
        imageView.applyConstraints(
            .centerX(to: contentView.centerXAnchor, constant: 0),
            .height(constant: 200))
    }
}
// MARK: - Setup Cell With data
extension ImageCollectionViewCell{
    func setup(model: ImageModel) {
        
    }
}
