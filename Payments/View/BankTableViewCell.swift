//
//  BankTableViewCell.swift
//  Payments
//
//  Created by Alejandro Villalobos on 01-04-23.
//

import UIKit
import SDWebImage
import SDWebImageSVGKitPlugin

class BankTableViewCell: UITableViewCell {
    private lazy var thumbnailImageView: SDAnimatedImageView = {
        let imageView = SDAnimatedImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.sd_imageTransition = .fade
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with bank: CardIssuer) {
        nameLabel.text = bank.name
        if let url = URL(string: bank.secureThumbnail) {
            SDImageCodersManager.shared.addCoder(SDImageSVGKCoder.shared)
            thumbnailImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    private func setupViewHierarchy() {
        addSubview(thumbnailImageView)
        addSubview(nameLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            thumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            thumbnailImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 40),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 40),
            
            nameLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setupCellAppearance() {
        backgroundColor = .systemGray6
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
