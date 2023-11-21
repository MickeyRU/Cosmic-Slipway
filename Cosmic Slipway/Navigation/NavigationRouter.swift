import UIKit

protocol NavigationRouterProtocol {
    func startNavigation()
    
    func navigateToShipTypeScreen()
    func navigateToShipSubTypeScreen(shipTypeID: UUID)
    func navigateToShipScreen(shipSubTypeID: UUID)
    func navigateToNewShipFittingScreen(shipID: UUID)
    func navigateToUserShipFittingScreen(shipID: UUID)
    
    func navigateToModuleTypeScreen()
    func navigateToModuleSubTypeScreen(moduleTypeID: UUID)
    func navigateToModulesScreen(moduleSubTypeID: UUID)
    
    func dismissToFittingViewController()
    func dismissToMainViewController()
    
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
    
    func navigateToNewShipFittingScreen(shipID: UUID) {
        let newShipFittingViewModel = CreatingShipFittingViewModel(shipID: shipID)
        let shipFittingVC = ShipFittingViewController(viewModel: newShipFittingViewModel, router: self)
        shipFittingVC.tabBarItem = UITabBarItem(title: "Fitting", image: NavigationImages.fittingTabBarClean, tag: 0)
        
        let shipNavVC = UINavigationController(rootViewController: shipFittingVC)
        
        let shipPowerVC = PowerViewController(router: self)
        shipPowerVC.tabBarItem = UITabBarItem(title: "Power", image: NavigationImages.fittingTabBarSelected, tag: 1)
        
        let tabBarController = MainTabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        tabBarController.viewControllers = [shipNavVC, shipPowerVC]
        
        navigationController.present(tabBarController, animated: true)
    }
    
    func navigateToUserShipFittingScreen(shipID: UUID) {
        let viewModel = EditingShipFittingViewModel(shipID: shipID)
        let shipFittingVC = ShipFittingViewController(viewModel: viewModel, router: self)
        shipFittingVC.tabBarItem = UITabBarItem(title: "Fitting", image: NavigationImages.fittingTabBarClean, tag: 0)
        
        let shipNavVC = UINavigationController(rootViewController: shipFittingVC)
        
        let shipPowerVC = PowerViewController(router: self)
        shipPowerVC.tabBarItem = UITabBarItem(title: "Power", image: NavigationImages.fittingTabBarSelected, tag: 1)
        
        let tabBarController = MainTabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        tabBarController.viewControllers = [shipNavVC, shipPowerVC]
        
        navigationController.present(tabBarController, animated: true)
    }

    
    func navigateToModuleTypeScreen() {
        let moduleTypeVC = ModuleTypeViewController(router: self)
        if let tabBarController = navigationController.presentedViewController as? UITabBarController {
            if let navigationController = tabBarController.selectedViewController as? UINavigationController {
                navigationController.pushViewController(moduleTypeVC, animated: true)
            }
        }
    }
    
    func navigateToModuleSubTypeScreen(moduleTypeID: UUID) {
        let moduleSubTypeVC = ModuleSubTypeViewController(moduleTypeID: moduleTypeID, router: self)
        if let tabBarController = navigationController.presentedViewController as? UITabBarController {
            if let navigationController = tabBarController.selectedViewController as? UINavigationController {
                navigationController.pushViewController(moduleSubTypeVC, animated: true)
            }
        }
    }
    
    func navigateToModulesScreen(moduleSubTypeID: UUID) {
        let modulesVC = ModulesViewController(moduleSubTypeID: moduleSubTypeID, router: self)
        if let tabBarController = navigationController.presentedViewController as? UITabBarController {
            if let navigationController = tabBarController.selectedViewController as? UINavigationController {
                navigationController.pushViewController(modulesVC, animated: true)
            }
        }
    }
    
    func dismissToFittingViewController() {
        if let tabBarController = navigationController.presentedViewController as? UITabBarController {
            if let navigationController = tabBarController.selectedViewController as? UINavigationController {
                navigationController.popToRootViewController(animated: true)
            }
        }
    }

    func dismissToMainViewController() {
        navigationController.popToRootViewController(animated: true)
        navigationController.dismiss(animated: true)
    }
}
