//
//  WeaponController.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 12.04.2023.
//

import UIKit

final class WeaponController: UIViewController {
    
    // MARK: - Constants
    
    var weapon: Weapon?

    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    private let bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = BgImages.shipSelectionBgImage
        return imageView
    }()
    
    private let backgroundView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = hexStringToUIColor(hex: BasicColors.darkBG, alpha: 0.7)
        return bgView
    }()
    
    private let backgroundViewTwo: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .clear
        return bgView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = hexStringToUIColor(hex: BasicColors.accent, alpha: 1.0)
        label.font = UIFont(name: Fonts.ebFigtree, size: 24)
        label.text = "Choose module"
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }
    
    // MARK: - Public methods
    
    // MARK: - Private Methods
    
    private func layout() {
        [bgImageView, backgroundView, backgroundViewTwo, titleLabel].forEach { view.addViews($0) }
        
        NSLayoutConstraint.activate([
            bgImageView.topAnchor.constraint(equalTo: view.topAnchor),
            bgImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bgImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            backgroundViewTwo.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundViewTwo.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
        ])
    }
}
