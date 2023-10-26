import UIKit

final class MainTabBarController: UITabBarController {
        
// MARK: - Private Properties
    
    private let mainViewController = MainViewController()
    
    // MARK: - ViewController LC
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTabBar()
    }
    
    // MARK: - Private Methods
    
    private func configTabBar() {
        tabBar.unselectedItemTintColor = BasicColors.iconText
        tabBar.tintColor = BasicColors.accent
        tabBar.backgroundColor = BasicColors.colorWithAlpha(BasicColors.darkBG, withAlpha: 0.7)
        tabBar.layer.cornerRadius = 20

        mainViewController.tabBarItem = UITabBarItem(
            title: "Dock",
            image: NavigationImages.homeTabBarClean,
            tag: 0
        )
        viewControllers = [mainViewController]
    }
}
