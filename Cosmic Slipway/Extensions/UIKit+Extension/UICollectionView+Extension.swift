//
//  UICollectionView+Extension.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 06.04.2023.
//

import UIKit

extension UICollectionViewCell {
    static func setupFittingCell(collectionView: UICollectionView, indexPath: IndexPath, title: String, Image: UIImage) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FittingCell.reuseIdentifier, for: indexPath) as! FittingCell
        cell.moduleTitle.text = title
        cell.moduleImage.image = Image
        cell.layer.cornerRadius = 24
        cell.clipsToBounds = true
        return cell
    }
}
