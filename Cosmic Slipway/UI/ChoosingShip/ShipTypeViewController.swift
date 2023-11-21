import UIKit
import SnapKit
import Combine

final class ShipTypeViewController: UIViewController {
    
    private let viewModel = SelectionViewModel<ShipType>(data: ShipManagementService.shared.loadShipTypesList())
    private let router: NavigationRouterProtocol
    
    private lazy var backgroundView = SelectionView<ShipType>(frame: .zero,
                                                              title: "Select ship type", backgroundType: .withImageView, backgroundImage: .shipSelection,
                                                              viewModel: viewModel)
    
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(router: NavigationRouterProtocol) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.selectedData
            .sink { [weak self] shipType in
                guard let self = self else { return }
                self.router.navigateToShipSubTypeScreen(shipTypeID: shipType.id)
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
