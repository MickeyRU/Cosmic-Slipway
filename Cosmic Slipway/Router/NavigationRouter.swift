import UIKit

protocol NavigationRouterProtocol {
    func setRootViewController(_ viewController: UIViewController)
    func startNavigation()
    
    func navigateToShipTypeScreen()
    func navigateToShipSubTypeScreen(shipTypeId: UUID)
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
    
    func navigateToShipTypeScreen() {
        let shipTypeSelectVC = ShipTypeViewController(router: self)
        navigationController.pushViewController(shipTypeSelectVC, animated: true)
    }
    
    func navigateToShipSubTypeScreen(shipTypeId: UUID) {
        let shipSubTypeSelectVC = ShipSubTypeViewController(router: self, shipTypeID: shipTypeId)
        navigationController.pushViewController(shipSubTypeSelectVC, animated: true)
    }
}
