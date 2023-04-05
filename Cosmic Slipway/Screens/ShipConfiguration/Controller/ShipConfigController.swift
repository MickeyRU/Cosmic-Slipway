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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let nextViewController = ShipTypeSelectionController()
            nextViewController.shipTypesDataArray = mockData
            navigationController?.pushViewController(nextViewController, animated: true)
        } else {
            print("else")
        }
    }
}

// MARK: - UICollectionViewDelegate

extension ShipConfigController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShipSelectedCell.reuseIdentifier, for: indexPath) as! ShipSelectedCell
        if let shipImage = ship?.shipImage {
            cell.shipImageView.image = UIImage(named: shipImage)
        }
        cell.shipTitle.text = ship?.name
        cell.shipStatusTitle.text = "Your Ship"
        cell.layer.cornerRadius = 28
        cell.clipsToBounds = true
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ShipConfigController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellInserts = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        let width = view.frame.width - (cellInserts.left + cellInserts.right)
        return CGSize(width: width, height: 96)
    }
}
