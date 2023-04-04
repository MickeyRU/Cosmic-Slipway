//
//  ViewController.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 25.03.2023.
//

import UIKit

final class HomeViewController: UICollectionViewController {
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    private let homeBgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = Images.homeBgImage
        return imageView
    }()
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    
    // MARK: - Private Methods
    
    private func configCollectionView() {
        collectionView.backgroundView = homeBgImageView
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ShipCell.self, forCellWithReuseIdentifier: ShipCell.reuseIdentifier)
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShipCell.reuseIdentifier, for: indexPath) as! ShipCell
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension HomeViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let destVC = MainShipTypeSelectionViewController()
            navigationController?.pushViewController(destVC, animated: true)
        } else {
            print("else")
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellInserts = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        let width = view.frame.width - (cellInserts.left + cellInserts.right)
        return CGSize(width: width, height: 96)
    }
}
