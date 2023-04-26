//
//  MainTabBarController.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 10.04.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    // MARK: - Constants
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    private let mainViewController = MainViewController()
    private let fittingViewController = ShipConfigController()
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTabBar()

    }
    
    // MARK: - Public methods
    
    // MARK: - Private Methods
    
    private func configTabBar() {
        tabBar.unselectedItemTintColor = UIColor(rgb: BasicColors.iconText)
        tabBar.tintColor = hexStringToUIColor(hex: BasicColors.accent, alpha: 1.0)
        tabBar.backgroundColor = hexStringToUIColor(hex: BasicColors.darkBG, alpha: 0.7)
        tabBar.layer.cornerRadius = 20

        mainViewController.tabBarItem = UITabBarItem(
            title: "Dock",
            image: NavigationImages.homeTabBarClean,
            tag: 0
        )
        viewControllers = [mainViewController]
    }
}
