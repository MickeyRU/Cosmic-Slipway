//
//  MainView.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 25.03.2023.
//

import UIKit

final class HomeView: UIView {
    // MARK: - Public Properties
    let shipCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.register(ShipCell.self, forCellWithReuseIdentifier: ShipCell.reuseIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Private Properties
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = Images.bgImage
        return imageView
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
        [backgroundImageView, shipCollectionView].forEach { addViews($0) }
    
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            shipCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 168),
            shipCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            shipCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            shipCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])
    }
}
