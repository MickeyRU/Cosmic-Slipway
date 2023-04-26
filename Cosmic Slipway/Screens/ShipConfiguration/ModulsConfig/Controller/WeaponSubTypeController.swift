//
//  WeaponSubTypeController.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 10.04.2023.
//

import UIKit

final class WeaponSubTypeController: UniversalSelectController {
    
    // MARK: - Public Properties
    
    var weaponSubTypesData = [WeaponSubtype]()
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weaponSubTypesData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UniversalSelectTypeCell.reuseIdentifier, for: indexPath) as! UniversalSelectTypeCell
        let weaponSubType = weaponSubTypesData[indexPath.item]
        cell.cellLabel.text = weaponSubType.name
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let weapon = weaponSubTypesData[indexPath.item]
        if indexPath.row == 2 {
            let nextVC = WeaponModuleController()
            nextVC.weaponModules = weapon.weaponModuleName
            navigationController?.pushViewController(nextVC, animated: true)
        } else {
            print("else")
        }
    }
}
