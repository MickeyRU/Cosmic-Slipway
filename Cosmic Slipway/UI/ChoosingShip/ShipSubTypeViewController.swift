import UIKit
import SnapKit
import Combine

final class ShipSubTypeViewController: UIViewController {
    
    private let shipTypeID: UUID
    
    private let router: NavigationRouterProtocol
    
    private lazy var viewModel = SelectionViewModel<ShipSubtype>(data: ShipManagementService.shared.getShipSubtypes(forShipTypeID: shipTypeID))
    
    private lazy var backgroundView = SelectionView<ShipSubtype>(frame: .zero,
                                                                 title: "Select ship subtype", backgroundType: .withImageView, backgroundImage: .shipSelection,
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
        
        viewModel.selectedData
            .sink { [weak self] shipSubType in
                guard let self = self else { return }
                self.router.navigateToShipScreen(shipSubTypeID: shipSubType.id)
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
