import UIKit

protocol NavigationRouterProtocol {
    func startNavigation()
    
    func navigateToShipTypeScreen()
    func navigateToShipSubTypeScreen(shipTypeID: UUID)
    func navigateToShipScreen(shipSubTypeID: UUID)
    
    func navigateToShipFittingScreen(shipID: UUID)
}

final class NavigationRouter: NavigationRouterProtocol {

    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func startNavigation() {
        let rootViewController = MainViewController(router: self)
        navigationController.pushViewController(rootViewController, animated: false)
    }
    
    func navigateToShipTypeScreen() {
        let shipTypeSelectVC = ShipTypeViewController(router: self)
        navigationController.pushViewController(shipTypeSelectVC, animated: true)
    }
    
    func navigateToShipSubTypeScreen(shipTypeID: UUID) {
        let shipSubTypeSelectVC = ShipSubTypeViewController(router: self, shipTypeID: shipTypeID)
        navigationController.pushViewController(shipSubTypeSelectVC, animated: true)
    }
    
    func navigateToShipScreen(shipSubTypeID: UUID) {
        let shipSelectVC = ShipViewController(router: self, shipSubTypeID: shipSubTypeID)
        navigationController.pushViewController(shipSelectVC, animated: true)
    }
    
    func navigateToShipFittingScreen(shipID: UUID) {
        let shipFittingVC = ShipFittingViewController(shipID: shipID)
        shipFittingVC.modalPresentationStyle = .fullScreen
        navigationController.present(shipFittingVC, animated: true)
    }
}
