import UIKit
import SnapKit
import Combine

final class ShipFittingViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let viewModel: ShipFittingViewModelProtocol
    private let shipFittingView: ShipFittingView
    private let router: NavigationRouterProtocol
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Init
    
    init(viewModel: ShipFittingViewModelProtocol, router: NavigationRouterProtocol) {
        self.viewModel = viewModel
        self.router = router
        self.shipFittingView = ShipFittingView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VC LC
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupViews()
        setupBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Private methods
    
    private func setupViews() {
        [shipFittingView].forEach { view.addSubview($0) }
        
        shipFittingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupBindings() {
        viewModel.ship
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.shipFittingView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.exitButtonTapped
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.router.dismissToMainViewController()
            }
            .store(in: &cancellables)
        
        viewModel.okButtonTapped
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.router.dismissToMainViewController()
            }
            .store(in: &cancellables)
        
        viewModel.moduleType
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.router.navigateToModuleTypeScreen()
            }
            .store(in: &cancellables)
    }
}
