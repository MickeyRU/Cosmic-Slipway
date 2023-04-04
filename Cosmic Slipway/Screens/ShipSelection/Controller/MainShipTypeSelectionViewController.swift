//
//  ShipTypeSelectionViewController.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 04.04.2023.
//

import UIKit

final class MainShipTypeSelectionViewController: UIViewController {
    // MARK: - Types
    
    // MARK: - Constants
    
    // MARK: - Public Properties
    
    // MARK: - IBOutlet
    
    // MARK: - Private Properties
    
    private let shipSelectionWindowVC = WindowShipSelectionController()
    
    private let bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = Images.shipSelectionBgImage
        return imageView
    }()
    
    // MARK: - Initializers
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shipSelectionWindowVC.modalPresentationStyle = .overFullScreen
        present(shipSelectionWindowVC, animated: true)
        
        layout()
    }
    
    // MARK: - Public methods
    
    // MARK: - IBAction
    
    // MARK: - Private Methods
    
    private func layout() {
        [bgImageView].forEach { view.addViews($0) }
        
        NSLayoutConstraint.activate([
            bgImageView.topAnchor.constraint(equalTo: view.topAnchor),
            bgImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bgImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
