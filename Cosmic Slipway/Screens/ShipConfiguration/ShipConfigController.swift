//
//  ShipConfigController.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 05.04.2023.
//

import UIKit

protocol ShipConfigControllerDelegate: AnyObject {
    func saveShipConfig(ship: Ship)
}

final class ShipConfigController: UIViewController {
    
    // MARK: - Public Properties
    var ship: Ship?
    
    weak var delegate: ShipConfigControllerDelegate?
    
    // MARK: - Private Properties
    private let shipConfigView = ShipConfigView()
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        configCollectionView()
        setupNavigationBar()
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonDidTapped))
    }
    
    @objc private func doneButtonDidTapped() {
        guard let ship = ship,
              let rootTabBarController = navigationController?.viewControllers.first as? MainTabBarController,
              let rootViewController = rootTabBarController.viewControllers?.first as? MainViewController
        else {
            print ("Не удалось достучаться до rootViewController")
            return
        }
        delegate = rootViewController
        delegate?.saveShipConfig(ship: ship)
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func layout() {
        [shipConfigView].forEach { view.addViews($0) }
        
        NSLayoutConstraint.activate([
            shipConfigView.topAnchor.constraint(equalTo: view.topAnchor),
            shipConfigView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            shipConfigView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            shipConfigView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func configCollectionView() {
        shipConfigView.shipConfigCollectionView.delegate = self
        shipConfigView.shipConfigCollectionView.dataSource = self
        shipConfigView.shipConfigCollectionView.showsVerticalScrollIndicator = false
    }
}

// MARK: - UICollectionViewDataSource

extension ShipConfigController: UICollectionViewDataSource {
    
}

// MARK: - UICollectionViewDelegate

extension ShipConfigController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let ship = self.ship else { return 0}
        switch section {
        case 0:
            return 1
        case 1:
            return ship.fitting.highSlots
        case 2:
            return ship.fitting.midSlots
        case 3:
            return ship.fitting.lowSlots
        case 4:
            return ship.fitting.combatRigs
        case 5:
            return ship.fitting.engineeringRigs
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShipSelectedCell.reuseIdentifier, for: indexPath) as! ShipSelectedCell
            if let shipImage = ship?.shipImage {
                cell.shipImageView.image = UIImage(named: shipImage)
            }
            cell.shipTitle.text = ship?.name
            cell.shipStatusTitle.text = "Your Ship"
            cell.layer.cornerRadius = 28
            cell.clipsToBounds = true
            return cell
        case 1:
            return UICollectionViewCell.setupFittingCell(collectionView: collectionView, indexPath: indexPath, title: "High Slot", Image: ModuleImages.highSlotClean)
        case 2:
            return UICollectionViewCell.setupFittingCell(collectionView: collectionView, indexPath: indexPath, title: "Mid Slot", Image: ModuleImages.midSlotClean)
        case 3:
            return UICollectionViewCell.setupFittingCell(collectionView: collectionView, indexPath: indexPath, title: "Low Slot", Image: ModuleImages.lowSlotClean)
        case 4:
            return UICollectionViewCell.setupFittingCell(collectionView: collectionView, indexPath: indexPath, title: "Combat Rig", Image: ModuleImages.combatRigClean)
        case 5:
            return UICollectionViewCell.setupFittingCell(collectionView: collectionView, indexPath: indexPath, title: "Engineering Rig", Image: ModuleImages.enginRigsClean)
        default:
            fatalError("Неожиданный индекс секции")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let destVC = WeaponTypeController()
            destVC.weaponTypeDataArray = highSlotsMockData
            navigationController?.pushViewController(destVC, animated: true)
        }
    }
}
