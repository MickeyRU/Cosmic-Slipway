//
//  ShipController.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 05.04.2023.
//

import UIKit

final class ShipSelectionController: UniversalSelectController {
    
    // MARK: - Public Properties
    
    var shipsDataArray = [Ship]()
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shipsDataArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UniversalSelectTypeCell.reuseIdentifier, for: indexPath) as! UniversalSelectTypeCell
        let ship = shipsDataArray[indexPath.item]
        cell.CellLabel.text = ship.name
        return cell
    }
    
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ship = shipsDataArray[indexPath.item]
        let nextTabBarController = UITabBarController()
        let nextVC = ShipConfigController()
        nextTabBarController.viewControllers = [nextVC]
        nextTabBarController.tabBar.unselectedItemTintColor = UIColor(rgb: BasicColors.iconText)
        nextTabBarController.tabBar.tintColor = hexStringToUIColor(hex: BasicColors.accent, alpha: 1.0)
        nextTabBarController.tabBar.backgroundColor = hexStringToUIColor(hex: BasicColors.darkBG, alpha: 0.7)
        nextTabBarController.tabBar.layer.cornerRadius = 20
        nextVC.tabBarItem = UITabBarItem(
            title: "Fitting",
            image: NavigationImages.homeTabBarClean,
            tag: 0
        )
        if indexPath.row == 3 {
            nextVC.ship = ship
            navigationController?.pushViewController(nextTabBarController, animated: true)
        } else {
            print("else")
        }
    }
    
}
