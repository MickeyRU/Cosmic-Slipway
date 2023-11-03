import UIKit
import SnapKit
import Combine

final class ShipTypeViewController: UIViewController {
    
    private let viewModel = BackgroundContainerViewModel<ShipType>(shipsData: ShipDataService.shared.getAllShipTypes())
    private let router: NavigationRouterProtocol
    
    private lazy var  backgroundView = BackgroundContainerView<ShipType>(frame: .zero,
                                                               title: "Select ship type",
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
        
        viewModel.selectedShipData
            .sink { shipType in
                print("Selected ship type: \(shipType.name)")
                // Здесь вы можете реагировать на выбранный тип корабля, например, открывать новый экран.
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
