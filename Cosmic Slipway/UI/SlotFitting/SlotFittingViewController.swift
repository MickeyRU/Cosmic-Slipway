import UIKit

final class SlotFittingViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let router: NavigationRouterProtocol
//    private lazy var selectionView = SelectionView<Ship>(frame: <#T##CGRect#>,
//                                                         title: <#T##String#>,
//                                                         viewModel: <#T##SelectionViewModel<Ship>#>)

    // MARK: - Init
    
    init(router: NavigationRouterProtocol) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
