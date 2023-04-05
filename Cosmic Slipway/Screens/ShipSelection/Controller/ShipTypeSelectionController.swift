//
//  ShipSelectionWindowControllerswift.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 04.04.2023.
//

import UIKit

final class ShipTypeSelectionController: UIViewController {
    
    // MARK: - Types
    
    // MARK: - Constants
    
    // MARK: - Public Properties
    var shipTypesDataArray = [ShipType]()
    
    // MARK: - IBOutlet
    
    // MARK: - Private Properties
    
    private let bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = Images.shipSelectionBgImage
        return imageView
    }()
    
    private let backgroundView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor(rgb: Colors.backgroundGray)
        bgView.alpha = 0.7
        return bgView
    }()
    
    private let backgroundViewTwo: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .clear
        return bgView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgb: Colors.accentColor)
        label.text = "Select type"
        label.textAlignment = .center
        label.font = UIFont(name: Fonts.ebFigtree, size: 24)
        return label
    }()
    
    private let shipTypeCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        configCollectionView()
        configNavigationBar()
    }
    
    // MARK: - Public methods
    
    // MARK: - IBAction
    
    // MARK: - Private Methods
    
    private func configNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func layout() {
        [bgImageView, backgroundView, backgroundViewTwo, titleLabel, shipTypeCollectionView].forEach { view.addViews($0) }
        
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
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            
            shipTypeCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            shipTypeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            shipTypeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48),
            shipTypeCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
        ])
    }
    
    private func configCollectionView() {
        shipTypeCollectionView.delegate = self
        shipTypeCollectionView.dataSource = self
        shipTypeCollectionView.register(ShipTypeCell.self, forCellWithReuseIdentifier: ShipTypeCell.reuseIdentifier)
        shipTypeCollectionView.showsVerticalScrollIndicator = false
    }
}

// MARK: - UICollectionViewDataSource

extension ShipTypeSelectionController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shipTypesDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShipTypeCell.reuseIdentifier, for: indexPath) as! ShipTypeCell
        let shipType = shipTypesDataArray[indexPath.item]
        cell.shipTitleLabel.text = shipType.name
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension ShipTypeSelectionController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let shipType = shipTypesDataArray[indexPath.item]
        if indexPath.row == 5 {
            let nextViewController = ShipSubTypeSelectionController()
            nextViewController.shipSubTypesDataArray = shipType.subtypes
            navigationController?.pushViewController(nextViewController, animated: true)
        } else {
            print("else")
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ShipTypeSelectionController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellInserts = UIEdgeInsets(top: 0, left: 48, bottom: 0, right: 48)
        let width = view.frame.width - (cellInserts.left + cellInserts.right)
        return CGSize(width: width, height: 44)
    }
}
