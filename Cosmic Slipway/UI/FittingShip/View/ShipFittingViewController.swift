import UIKit
import SnapKit
import Combine

final class ShipFittingViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let ship: UUID
    private let viewModel: ShipFittingViewModel
    private var cancellables: Set<AnyCancellable> = []
    private let shipFittingView: ShipFittingView
    
    // MARK: - Init
    
    init(shipID: UUID) {
        self.viewModel = ShipFittingViewModel(shipID: shipID)
        self.ship = shipID
        self.shipFittingView = ShipFittingView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VC LC
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.ship
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.shipFittingView.reloadData()
            }
            .store(in: &cancellables)
        
        setupViews()
    }
    
    // MARK: - Private methods
    
    private func setupViews() {
        [shipFittingView].forEach { view.addSubview($0) }
        
        shipFittingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
