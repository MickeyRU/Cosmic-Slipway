import UIKit

final class PowerViewController: UIViewController {
    
    private let router: NavigationRouter
    
    init(router: NavigationRouter) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .red
    }
}
