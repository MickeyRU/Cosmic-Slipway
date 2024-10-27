import UIKit
import Combine

final class ModuleTypeViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let router: NavigationRouterProtocol
    
    private lazy var viewModel = SelectionViewModel<ModuleType>(data: ModuleManagementService.shared.getModuleTypes())
    private lazy var selectionView = SelectionView<ModuleType>(frame: .zero,
                                                               title: "Choose weapon type", backgroundType: .withImageView, backgroundImage: .main,
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
            .sink { [weak self] moduleType in
                guard let self = self else { return }
                self.router.navigateToModuleSubTypeScreen(moduleTypeID: moduleType.id)
            }
            .store(in: &subscriptions)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setupViews() {
        [selectionView].forEach { view.addSubview($0) }
    
        selectionView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    }
}
