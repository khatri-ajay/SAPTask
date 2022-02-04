//
//  LabelTableViewCell.swift
//  SAPTask
//
//  Created by Ajay Kumar on 04/02/2022.
//

import UIKit


class LabelTableViewCell: UITableViewCell {
    private let title: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.2
        label.adjustsFontSizeToFitWidth = true
        return label
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
extension LabelTableViewCell{
    private func setupViews() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 5
        contentView.backgroundColor = .systemGray6
        title.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(title)
    }
}
// MARK: - Adding Constraints
extension LabelTableViewCell{
    private func setupLayouts() {
        // Title Constraints
        title.applyConstraints(
            .top(to: contentView.topAnchor, constant: 5),
            .bottom(to: contentView.bottomAnchor, constant: -5),
            .leading(to: contentView.leadingAnchor, constant: 5),
            .trailing(to: contentView.trailingAnchor, constant: -5),
            .height(constant: 30))
    }
}
// MARK: - Setup Cell With data
extension LabelTableViewCell{
    func setup(text: String) {
        title.text = text
    }
}
