import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var navigationController: UINavigationController?
    var navigationRouter: NavigationRouterProtocol?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        setupNavigationController()
        
        let mainTabBarController = MainTabBarController()
        
        guard let navigationController = navigationController,
              let navigationRouter = navigationRouter
        else { return }
        
        navigationRouter.setRootViewController(mainTabBarController)
        navigationRouter.startNavigation()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    private func setupNavigationController() {
        navigationController = UINavigationController()
        
        guard let navigationController = navigationController else { return }
        
        navigationController.navigationBar.tintColor = .white
        configureNavigationBarAppearance()
        
        navigationRouter = NavigationRouter(navigationController: navigationController)
    }
    
    private func configureNavigationBarAppearance() {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: CustomFonts.figtreeExBold18 as Any
        ]
        
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: .highlighted)
    }
}
