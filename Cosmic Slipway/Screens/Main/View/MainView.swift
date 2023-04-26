//
//  MainView.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 05.04.2023.
//

import UIKit

final class MainView: UIView {
    
    // MARK: - Types

    // MARK: - Constants

    // MARK: - Public Properties

    // MARK: - Private Properties
    
    private let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = BgImages.mainBackImage
        return imageView
    }()
    
    let shipCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(ShipsCell.self, forCellWithReuseIdentifier: ShipsCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Public methods

    // MARK: - Private Methods
    
    private func layout() {
        [backImageView, shipCollectionView].forEach { addViews($0) }
        
        NSLayoutConstraint.activate([
            backImageView.topAnchor.constraint(equalTo: topAnchor),
            backImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            shipCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            shipCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shipCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shipCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
