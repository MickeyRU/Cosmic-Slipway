//
//  SlotsFittingController.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 06.04.2023.
//

import UIKit

final class HighSlotsFittingController: UIViewController {
        
    
    // MARK: - Public Properties
    var highSlotModules = [HighSlotModule]()
        
    // MARK: - Private Properties
    
    private let backgroundView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor(rgb: Colors.backgroundGray)
        bgView.alpha = 0.9
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
        label.text = "Select weapon type"
        label.textAlignment = .center
        label.font = UIFont(name: Fonts.ebFigtree, size: 24)
        return label
    }()
    
    private let weaponTypeCollectionView: UICollectionView = {
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
    
    
    // MARK: - Private Methods
    
    private func configNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func layout() {
        [backgroundView, backgroundViewTwo, titleLabel, weaponTypeCollectionView].forEach { view.addViews($0) }
        
        NSLayoutConstraint.activate([
       
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
            
            weaponTypeCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            weaponTypeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            weaponTypeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48),
            weaponTypeCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
        ])
    }
    
    private func configCollectionView() {
        weaponTypeCollectionView.delegate = self
        weaponTypeCollectionView.dataSource = self
        weaponTypeCollectionView.register(UniversalSelectTypeCell.self, forCellWithReuseIdentifier: UniversalSelectTypeCell.reuseIdentifier)
        weaponTypeCollectionView.showsVerticalScrollIndicator = false
    }
}

// MARK: - UICollectionViewDataSource

extension HighSlotsFittingController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return highSlotModules.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UniversalSelectTypeCell.reuseIdentifier, for: indexPath) as! UniversalSelectTypeCell
        let hightSlotModule = highSlotModules[indexPath.item]
        cell.CellLabel.text = hightSlotModule.name
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension HighSlotsFittingController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 5 {
            
        } else {
            print("else")
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HighSlotsFittingController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellInserts = UIEdgeInsets(top: 0, left: 48, bottom: 0, right: 48)
        let width = view.frame.width - (cellInserts.left + cellInserts.right)
        return CGSize(width: width, height: 48)
    }
}
