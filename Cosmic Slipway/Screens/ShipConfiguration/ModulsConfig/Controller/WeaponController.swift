//
//  WeaponController.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 10.04.2023.
//

import UIKit

final class WeaponController: UniversalSelectController {
    
    // MARK: - Public Properties
    var weapon = [Weapon]()
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weapon.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UniversalSelectTypeCell.reuseIdentifier, for: indexPath) as! UniversalSelectTypeCell
        let weapon = weapon[indexPath.item]
        cell.CellLabel.text = weapon.name
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            
        } else {
            print("else")
        }
    }
}
