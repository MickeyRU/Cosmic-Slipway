import UIKit

final class MainTabBarController: UITabBarController {
        
    // MARK: - ViewController LC
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTabBar()
    }
    
    // MARK: - Private Methods
    
    private func configTabBar() {
        tabBar.unselectedItemTintColor = UIColor.iconText
        tabBar.tintColor = UIColor.accent
        tabBar.backgroundColor = UIColor.darkBG.withAlphaComponent(0.7)
        tabBar.layer.cornerRadius = 28
    }
}
