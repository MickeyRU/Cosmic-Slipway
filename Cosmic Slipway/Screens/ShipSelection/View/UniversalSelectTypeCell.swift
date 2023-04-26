//
//  ShipTypeCell.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 04.04.2023.
//

import UIKit

final class UniversalSelectTypeCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    static let reuseIdentifier = "UniversalSelectTypeCell"
    
    // MARK: - Private Properties
    
    private let backBorderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = BgImages.backBorderImage
        return imageView
    }()
    
    let cellLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Frigates"
        label.textAlignment = .center
        label.font = UIFont(name: Fonts.ebFigtree, size: 16)
        return label
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func layout() {
        [backBorderImageView, cellLabel].forEach { addViews($0) }
        
        NSLayoutConstraint.activate([
            backBorderImageView.topAnchor.constraint(equalTo: topAnchor),
            backBorderImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backBorderImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backBorderImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            cellLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            cellLabel.leadingAnchor.constraint(equalTo: backBorderImageView.leadingAnchor, constant: 17),
            cellLabel.trailingAnchor.constraint(equalTo: backBorderImageView.trailingAnchor, constant: -17),
            cellLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
