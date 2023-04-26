//
//  ViewController.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 25.03.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    private let mainView = MainView()
    private var shipsArray = [Ship]()
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        configCollectionView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.shipCollectionView.reloadData()
    }
    
    // MARK: - Private Methods
    
    private func layout() {
        [mainView].forEach { view.addViews($0) }
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func configCollectionView() {
        mainView.shipCollectionView.delegate = self
        mainView.shipCollectionView.dataSource = self
        mainView.shipCollectionView.showsVerticalScrollIndicator = false
    }
}

// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let startSelectionController = UniversalSelectController()
            startSelectionController.shipTypesDataArray = shipsMockData
            navigationController?.pushViewController(startSelectionController, animated: true)
        } else {
            print("else")
        }
    }
}

// MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.shipsArray.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShipsCell.reuseIdentifier, for: indexPath) as? ShipsCell else {
            return UICollectionViewCell()
        }
        
        cell.layer.cornerRadius = 28
        cell.clipsToBounds = true
        
        if indexPath.row == 0 {
        } else if indexPath.row - 1 < shipsArray.count {
            let ship = shipsArray[indexPath.row - 1]
            cell.shipImageView.image = UIImage(named: ship.shipImage)
            cell.shipTitle.text = ship.name
        }
        return cell
    }
}
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    extension MainViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let cellInserts = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
            let width = view.frame.width - (cellInserts.left + cellInserts.right)
            return CGSize(width: width, height: 96)
        }
    }
    
    // MARK: - ShipConfigControllerDelegate
    
    extension MainViewController: ShipConfigControllerDelegate {
        func saveShipConfig(ship: Ship) {
            shipsArray.append(ship)
        }
    }
