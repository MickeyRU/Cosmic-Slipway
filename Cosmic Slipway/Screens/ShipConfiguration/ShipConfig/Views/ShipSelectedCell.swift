//
//  ChoosenShipCell.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 05.04.2023.
//

import UIKit

final class ShipSelectedCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    static let reuseIdentifier = "ShipSelectedCell"
    
    // MARK: - Private PropertieshomeTabBar
    
    private let backgroundImageView: UIView = {
        let view = UIView()
        view.backgroundColor = hexStringToUIColor(hex: BasicColors.darkBG, alpha: 0.7)
        return view
    }()
    
    let shipImageView: UIImageView = {
        let imageView = UIImageView(image: ShipImages.defaultShipImage)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let shipTitle: UILabel = {
        let label = UILabel()
        label.text = "New ship"
        label.textAlignment = .left
        label.textColor = hexStringToUIColor(hex: BasicColors.accent, alpha: 1.0)
        label.font = UIFont(name: Fonts.ebFigtree, size: 16)
        return label
    }()
    
    let shipStatusTitle: UILabel = {
        let label = UILabel()
        label.text = "Configure"
        label.textAlignment = .left
        label.textColor = UIColor(rgb: BasicColors.iconText)
        label.font = UIFont(name: Fonts.rFigtree, size: 12)
        return label
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupCell() {
        layer.cornerRadius = 28
    }
    
    private func layout() {
        [backgroundImageView, shipImageView, shipTitle, shipStatusTitle].forEach { addViews($0) }
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            shipImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            shipImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            shipImageView.widthAnchor.constraint(equalToConstant: 60),
            shipImageView.heightAnchor.constraint(equalToConstant: 60),
            
            shipTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            shipTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -35),
            
            shipStatusTitle.leadingAnchor.constraint(equalTo: shipTitle.leadingAnchor),
            shipStatusTitle.bottomAnchor.constraint(equalTo: shipTitle.topAnchor, constant: -6),
        ])
    }
}
