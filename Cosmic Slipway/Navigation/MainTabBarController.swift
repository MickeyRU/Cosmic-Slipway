import UIKit

final class MainTabBarController: UITabBarController {
        
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

        tabBarItem = UITabBarItem(
            title: "Dock",
            image: NavigationImages.homeTabBarClean,
            tag: 0
        )
    }
}
