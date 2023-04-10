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
    
    let shipConfigCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.register(ShipSelectedCell.self, forCellWithReuseIdentifier: ShipSelectedCell.reuseIdentifier)
        collectionView.register(FittingCell.self, forCellWithReuseIdentifier: FittingCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    // MARK: - Private Properties

    private let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = BgImages.mainBackImage
        return imageView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
        configureCollectionViewLayout()
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
    
    private func configureCollectionViewLayout() {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection in
            switch sectionIndex {
            case 0:
                // Секция с одной ячейкой на всю ширину экрана
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(96)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(96)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 50, trailing: 24)
                return section
                
            case 1...3:
                // Секции со скроллом влево
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(48)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(118), heightDimension: .absolute(48)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 24, trailing: 24)
                section.orthogonalScrollingBehavior = .continuous
                return section
                
            case 4:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(48)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(128), heightDimension: .absolute(48)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 24, bottom: 24, trailing: 24)
                section.orthogonalScrollingBehavior = .continuous
                return section
                
            case 5:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(48)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(150), heightDimension: .absolute(48)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 24, trailing: 24)
                section.orthogonalScrollingBehavior = .continuous
                return section
            default:
                fatalError("configureCollectionViewLayout - Неожиданный индекс секции")
            }
        }
        shipConfigCollectionView.collectionViewLayout = layout
    }
}
