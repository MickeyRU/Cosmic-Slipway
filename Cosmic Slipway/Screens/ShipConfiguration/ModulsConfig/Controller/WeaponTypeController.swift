//
//  WeaponTypeController.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 06.04.2023.
//

import UIKit

final class WeaponTypeController: UniversalSelectController {
    
    // MARK: - Public Properties
    var weaponTypeDataArray = [HighSlotsMainWeaponType]()
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weaponTypeDataArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UniversalSelectTypeCell.reuseIdentifier, for: indexPath) as! UniversalSelectTypeCell
        let hightSlotModule = weaponTypeDataArray[indexPath.item]
        cell.CellLabel.text = hightSlotModule.name
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let weaponSubType = weaponTypeDataArray[indexPath.item]
        if indexPath.row == 1 {
            let nextVC = WeaponSubTypeController()
            nextVC.weaponSubTypesData = weaponSubType.subtype
            navigationController?.pushViewController(nextVC, animated: true)
        } else {
            print("else")
        }
    }
}
