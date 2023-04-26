//
//  ShipSubTypeSelectionController.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 04.04.2023.
//

import UIKit

final class ShipSubTypeSelectionController: UniversalSelectController {
    
    // MARK: - Public Properties
    
    var shipSubTypesDataArray = [ShipSubtype]()
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shipSubTypesDataArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UniversalSelectTypeCell.reuseIdentifier, for: indexPath) as! UniversalSelectTypeCell
        let ship = shipSubTypesDataArray[indexPath.item]
        cell.cellLabel.text = ship.name
        return cell
    }
    
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let shipSubType = shipSubTypesDataArray[indexPath.item]
        if indexPath.row == 1 {
            let nextViewController = ShipSelectionController()
            nextViewController.shipsDataArray = shipSubType.ships
            navigationController?.pushViewController(nextViewController, animated: true)
        } else {
            print("else")
        }
    }
}
