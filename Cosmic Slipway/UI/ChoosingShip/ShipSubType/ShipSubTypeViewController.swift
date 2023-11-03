import UIKit
import SnapKit
import Combine

final class ShipSubTypeViewController: UIViewController {
    
    private let shipTypeID: UUID
    
    private let router: NavigationRouterProtocol
    
    private lazy var viewModel = BackgroundContainerViewModel<ShipSubtype>(shipsData: ShipDataService.shared.getShipSubtypes(forShipTypeId: shipTypeID))
    
    private lazy var backgroundView = BackgroundContainerView<ShipSubtype>(frame: .zero,
                                                                           title: "Select ship subtype",
                                                                           viewModel: viewModel)
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(router: NavigationRouterProtocol, shipTypeID: UUID) {
        self.router = router
        self.shipTypeID = shipTypeID
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
