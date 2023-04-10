//
//  SlotsFittingController.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 06.04.2023.
//

import UIKit

final class HighSlotsFittingController: UniversalSelectController {
    
    // MARK: - Public Properties
    var highSlotModules = [HighSlotsMainWeaponType]()
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return highSlotModules.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UniversalSelectTypeCell.reuseIdentifier, for: indexPath) as! UniversalSelectTypeCell
        let hightSlotModule = highSlotModules[indexPath.item]
        cell.CellLabel.text = hightSlotModule.name
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
