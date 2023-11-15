import UIKit
import Combine

final class ModulesViewController: UIViewController {
    
    // MARK: - Private Properties
    private let moduleSubTypeID: UUID
    private let router: NavigationRouterProtocol
    
    private lazy var viewModel = SelectionViewModel<Module>(data: ModuleManagementService.shared.sortModuleFromSubTypes(moduleSubTypeID: moduleSubTypeID))
    private lazy var selectionView = SelectionView<Module>(frame: .zero,
                                                                  title: "Choose weapon", backgroundType: .withImageView, backgroundImage: .main,
                                                         viewModel: viewModel)
    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Init
    
    init(moduleSubTypeID: UUID, router: NavigationRouterProtocol) {
        self.moduleSubTypeID = moduleSubTypeID
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
            .sink { [weak self] module in
                guard let self = self else { return }
                ModuleManagementService.shared.userSelectModule(moduleID: module.id)
                self.router.dismissToFittingViewController()
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
