//
//  ViewController.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 25.03.2023.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - Public Properties
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Private Properties
    private let mainView = HomeView()
    
    // MARK: - VC life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.shipCollectionView.delegate = self
        mainView.shipCollectionView.dataSource = self
        layout()
    }
    
    // MARK: - Private Methods
    private func layout() {
        view.addViews(mainView)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShipCell.reuseIdentifier, for: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionInserts = UIEdgeInsets(top: 10, left: 24, bottom: 10, right: 24)
        let width = view.frame.width - (sectionInserts.left + sectionInserts.right)
        return CGSize(width: width, height: 96)
    }
}
