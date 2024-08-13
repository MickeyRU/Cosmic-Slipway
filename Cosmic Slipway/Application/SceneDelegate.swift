import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var navigationRouter: NavigationRouterProtocol?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let navigationController = UINavigationController()
        navigationRouter = NavigationRouter(navigationController: navigationController)
        
        navigationRouter?.startNavigation()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        configureNavigationBarAppearance()
    }
    
    private func configureNavigationBarAppearance() {
        let attributes: [NSAttributedString.Key: Any] = [.font: AppFonts.figtreeExBold18 as Any]
        
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: .highlighted)
        
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = attributes
    }
}
