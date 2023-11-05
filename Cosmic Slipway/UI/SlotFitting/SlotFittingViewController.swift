import UIKit
import Combine

final class SlotFittingViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let router: NavigationRouterProtocol
    
    private lazy var viewModel = SelectionViewModel<ModuleType>(data: ModuleManagementService.shared.getModuleTypes())
    private lazy var selectionView = SelectionView<ModuleType>(frame: .zero,
                                                         title: "Choose weapon type",
                                                         viewModel: viewModel)
    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Init
    
    init(router: NavigationRouterProtocol) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.selectedData
            .sink { [weak self] ModuleType in
                guard let self = self else { return }
//                self.router.navigateToShipSubTypeScreen(shipTypeID: shipType.id)
            }
            .store(in: &subscriptions)
    }
    
    private func setupViews() {
        [selectionView].forEach { view.addSubview($0) }
    
        selectionView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    }
}
