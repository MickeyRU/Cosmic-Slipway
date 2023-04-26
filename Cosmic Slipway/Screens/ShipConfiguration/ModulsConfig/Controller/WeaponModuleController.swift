//
//  WeaponController.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 10.04.2023.
//

import UIKit

final class WeaponModuleController: UniversalSelectController {
    
    // MARK: - Public Properties
    
    var weaponModules = [Weapon]()
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weaponModules.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UniversalSelectTypeCell.reuseIdentifier, for: indexPath) as! UniversalSelectTypeCell
        let weapon = weaponModules[indexPath.item]
        cell.cellLabel.text = weapon.name
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let weapon = weaponModules[indexPath.item]
        if indexPath.row == 0 {
            let nextVC = WeaponController()
            nextVC.weapon = weapon
            navigationController?.pushViewController(nextVC, animated: true)
        } else {
            print("else")
        }
    }
}
