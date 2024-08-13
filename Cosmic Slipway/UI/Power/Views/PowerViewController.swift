import UIKit
import SnapKit
import Combine

private enum collectionViewInsets {
    static let sideInsets: CGFloat = 24
}

final class PowerViewController: UIViewController {
    private let router: NavigationRouter
    private let viewModel: PowerViewModelProtocol
    private let viewsFactory: ViewsFactoryProtocol
    
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var bgImageView: UIImageView = {
        viewsFactory.createBGImageView(for: .shipSelection)
    }()
    
    private lazy var attributesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 40, right: 0)
        collectionView.register(AttributeCell.self, forCellWithReuseIdentifier: AttributeCell.reuseIdentifier)
        return collectionView
    }()
    
    
    init(router: NavigationRouter,
         viewModel: PowerViewModelProtocol,
         viewsFactory: ViewsFactoryProtocol = ViewsFactory()
    ) {
        self.router = router
        self.viewModel = viewModel
        self.viewsFactory = viewsFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBindings()
    }
    
    private func setupViews() {
        [bgImageView, attributesCollectionView].forEach { view.addSubview($0) }
        
        bgImageView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(view)
        }
        
        attributesCollectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view)
        }
    }
    
    private func setupBindings() {
        viewModel.cellConfigurationsSubject
            .sink { [weak self] _ in
                self?.attributesCollectionView.reloadData()
            }
            .store(in: &subscriptions)
    }
}

// MARK: - UICollectionViewDataSource

extension PowerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard 
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AttributeCell.reuseIdentifier, for: indexPath) as? AttributeCell,
            let configuration = viewModel.configurationForCell(at: indexPath)
        else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: configuration)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension PowerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cellHeight = viewModel.configurationForCell(at: indexPath)?.type.height else { return CGSize() }
        let width = view.frame.width - (collectionViewInsets.sideInsets + collectionViewInsets.sideInsets)
        return CGSize(width: width, height: cellHeight)
    }
}
