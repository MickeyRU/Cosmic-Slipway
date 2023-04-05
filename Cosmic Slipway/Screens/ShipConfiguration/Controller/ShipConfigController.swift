//
//  ShipConfigController.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 05.04.2023.
//

import UIKit

final class ShipConfigController: UIViewController {
    
    // MARK: - Public Properties
    var ship: Ship?
    
    // MARK: - Private Properties
    private let shipConfig = ShipConfigView()
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        configCollectionView()
    }
    
    // MARK: - Private Methods
    
    private func layout() {
        [shipConfig].forEach { view.addViews($0) }
        
        NSLayoutConstraint.activate([
            shipConfig.topAnchor.constraint(equalTo: view.topAnchor),
            shipConfig.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            shipConfig.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            shipConfig.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func configCollectionView() {
        shipConfig.shipConfigCollectionView.delegate = self
        shipConfig.shipConfigCollectionView.dataSource = self
    }
}

// MARK: - UICollectionViewDataSource

extension ShipConfigController: UICollectionViewDataSource {
    
}

// MARK: - UICollectionViewDelegate

extension ShipConfigController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShipSelectedCell.reuseIdentifier, for: indexPath) as! ShipSelectedCell
            if let shipImage = ship?.shipImage {
                cell.shipImageView.image = UIImage(named: shipImage)
            }
            cell.shipTitle.text = ship?.name
            cell.shipStatusTitle.text = "Your Ship"
            cell.layer.cornerRadius = 28
            cell.clipsToBounds = true
            return cell
        case 1...5:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FittingCell.reuseIdentifier, for: indexPath) as! FittingCell
            cell.layer.cornerRadius = 28
            cell.clipsToBounds = true
            return cell
        default:
            fatalError("Неожиданный индекс секции")
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ShipConfigController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        default:
            return UIEdgeInsets(top: 0, left: 24, bottom: 24, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            let cellInserts = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
            let width = view.frame.width - (cellInserts.left + cellInserts.right)
            return CGSize(width: width, height: 96)
        case 1...5:
            return CGSize(width: 118, height: 48)
        default:
            fatalError("Неожиданный размер секции")
        }
    }
}
