import SnapKit
import UIKit
import Combine

final class MainViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let router: NavigationRouterProtocol
    
    private let viewModel: MainViewModelProtocol
    
    private let viewsFactory: ViewsFactoryProtocol
    
    private var cancellables: Set<AnyCancellable> = []
    
    private lazy var bgImageView: UIImageView = {
        viewsFactory.createBGImageView(for: .main)
    }()
    
    private lazy var shipCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(ShipsCell.self, forCellWithReuseIdentifier: ShipsCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private enum collectionViewInsets {
        static let sideInsets: CGFloat = 24
        static let cellHeight: CGFloat = 96
    }
    
    // MARK: - init
    
    init(viewsFactory: ViewsFactoryProtocol = ViewsFactory(),
         viewModel: MainViewModelProtocol = MainViewModel(),
         router: NavigationRouterProtocol) {
        self.viewsFactory = viewsFactory
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController LC
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.shipsPublisher
            .sink(receiveValue: { [weak self] _ in
                guard let self = self else { return }
                self.shipCollectionView.reloadData()
            })
            .store(in: &cancellables)
        
        setupViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        [bgImageView, shipCollectionView].forEach { view.addSubview($0) }
        
        bgImageView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(view)
        }
        
        shipCollectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.ships.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShipsCell.reuseIdentifier, for: indexPath) as? ShipsCell else {
            return UICollectionViewCell()
        }
        cell.layer.cornerRadius = 28
        cell.clipsToBounds = true
        
        switch indexPath.row {
        case 0:
            return cell
        default:
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellInserts = UIEdgeInsets(top: 0, left: collectionViewInsets.sideInsets, bottom: 0, right: collectionViewInsets.sideInsets)
        let width = view.frame.width - (cellInserts.left + cellInserts.right)
        return CGSize(width: width, height: collectionViewInsets.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            router.navigateToShipTypeScreen()
        default:
            break
        }
    }
}
