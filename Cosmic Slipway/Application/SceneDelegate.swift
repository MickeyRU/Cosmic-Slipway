import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var navigationController: UINavigationController?
    var navigationRouter: NavigationRouterProtocol?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        navigationController = UINavigationController()
        
        if let navigationController = navigationController {
            navigationRouter = NavigationRouter(navigationController: navigationController)
        }

        let mainTabBarController = MainTabBarController()
        
        if let navigationController = navigationController, let navigationRouter = navigationRouter {
            navigationRouter.setRootViewController(mainTabBarController)
            
            navigationRouter.startNavigation()
            
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
    }
}
