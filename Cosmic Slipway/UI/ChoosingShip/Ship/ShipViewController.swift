import UIKit
import SnapKit
import Combine

final class ShipViewController: UIViewController {
    
    private let shipSubTypeID: UUID
    
    private let router: NavigationRouterProtocol
    
    private lazy var viewModel = BackgroundContainerViewModel<Ship>(shipsData: ShipDataService.shared.getShips(forShipSubTypeID: shipSubTypeID))
    
    private lazy var backgroundView = BackgroundContainerView<Ship>(frame: .zero,
                                                                           title: "Select ship",
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
    }
    
    private func layout() {
        [backgroundView].forEach { view.addSubview($0) }
        
        backgroundView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    }
}
