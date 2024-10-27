import UIKit
import SnapKit
import Combine

final class ShipViewController: UIViewController {
    
    private let shipSubTypeID: UUID
    
    private let router: NavigationRouterProtocol
    
    private lazy var viewModel = SelectionViewModel<Ship>(data: ShipManagementService.shared.loadShipsList(for: shipSubTypeID))
    
    private lazy var backgroundView = SelectionView<Ship>(frame: .zero,
                                                          title: "Select ship", backgroundType: .withImageView, backgroundImage: .shipSelection,
                                                                           viewModel: viewModel)
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(router: NavigationRouterProtocol, shipSubTypeID: UUID) {
        self.router = router
        self.shipSubTypeID = shipSubTypeID
        super.init(nibName: nil, bundle: nil)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.selectedData
            .sink { [weak self] ship in
                guard let self = self else { return }
                self.router.navigateToNewShipFittingScreen(shipID: ship.id)
            }
            .store(in: &subscriptions)
    }
    
    private func layout() {
        [backgroundView].forEach { view.addSubview($0) }
        
        backgroundView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    }
}
