//
//  ShipCell.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 26.03.2023.
//

import UIKit

final class ShipCell: UICollectionViewCell {
    // MARK: - Public Properties
    static let reuseIdentifier = "ShipCell"
    
    // MARK: - Private Properties
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = Images.bgCellImage
        return imageView
    }()
    
    private let shipImageView: UIImageView = {
        let imageView = UIImageView(image: Images.defaultShipImage)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let shipTitle: UILabel = {
        let label = UILabel()
        label.text = "New ship"
        label.textAlignment = .left
        label.textColor = UIColor(rgb: Colors.accentColor)
        label.font = Fonts.ebFigtree
        return label
    }()
    
    private let shipStatusTitle: UILabel = {
        let label = UILabel()
        label.text = "Configure"
        label.textAlignment = .left
        label.textColor = UIColor(rgb: Colors.textHelpers)
        label.font = Fonts.rFigtree
        return label
    }()
    
    private let addShipButton: UIButton = {
        let button = UIButton()
        button.setImage(Images.addButtonImage, for: .normal)
        return button
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
        [backgroundImageView, shipImageView, shipTitle, shipStatusTitle, addShipButton].forEach { addViews($0) }
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            shipImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            shipImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            shipImageView.widthAnchor.constraint(equalToConstant: 64),
            shipImageView.heightAnchor.constraint(equalToConstant: 60),
            
            shipTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            shipTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -35),
            
            shipStatusTitle.leadingAnchor.constraint(equalTo: shipTitle.leadingAnchor),
            shipStatusTitle.bottomAnchor.constraint(equalTo: shipTitle.topAnchor, constant: -6),
            
            addShipButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -4),
            addShipButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            addShipButton.widthAnchor.constraint(equalToConstant: 80),
            addShipButton.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}
