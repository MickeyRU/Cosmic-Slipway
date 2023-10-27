import UIKit

protocol NavigationRouterProtocol {
    func setRootViewController(_ viewController: UIViewController)
    func startNavigation()
}

final class NavigationRouter: NavigationRouterProtocol {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func setRootViewController(_ viewController: UIViewController) {
        navigationController.viewControllers = [viewController]
    }
    
    func startNavigation() {
        let rootViewController = MainViewController(router: self)
        navigationController.pushViewController(rootViewController, animated: false)
    }
}
