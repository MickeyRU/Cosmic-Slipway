//
//  ShipConfigView.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 05.04.2023.
//

import UIKit

final class ShipConfigView: UIView {
    
    // MARK: - Types

    // MARK: - Constants

    // MARK: - Public Properties

    // MARK: - Private Properties
    
    private let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = Images.mainBackImage
        return imageView
    }()
    
    let shipConfigCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(ShipSelectedCell.self, forCellWithReuseIdentifier: ShipSelectedCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
        configShipCollectionView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Public methods

    // MARK: - Private Methods
    
    private func layout() {
        [backImageView, shipConfigCollectionView].forEach { addViews($0) }
        
        NSLayoutConstraint.activate([
            backImageView.topAnchor.constraint(equalTo: topAnchor),
            backImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            shipConfigCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            shipConfigCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shipConfigCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shipConfigCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configShipCollectionView() {
        
    }
}
