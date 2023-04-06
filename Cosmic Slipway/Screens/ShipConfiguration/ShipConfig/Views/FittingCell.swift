//
//  FittingCell.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 05.04.2023.
//

import UIKit

final class FittingCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    static let reuseIdentifier = "FittingCell"
    
    // MARK: - Private Properties
    
    private let backgroundImageView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgb: Colors.backgroundGray)
        view.alpha = 0.7
        return view
    }()
    
    let moduleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let moduleTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont(name: Fonts.ebFigtree, size: 12)
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
    
    // MARK: - Public methods
    
    // MARK: - Private Methods
    
    private func layout() {
        [backgroundImageView, moduleImage, moduleTitle].forEach { addViews($0) }
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            moduleImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            moduleImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            moduleImage.widthAnchor.constraint(equalToConstant: 24),
            moduleImage.heightAnchor.constraint(equalToConstant: 24),
            
            moduleTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
            moduleTitle.leadingAnchor.constraint(equalTo: moduleImage.trailingAnchor, constant: 8),
            moduleTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
        ])
    }
}
