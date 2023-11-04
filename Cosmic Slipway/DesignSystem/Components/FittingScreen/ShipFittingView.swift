import UIKit
import SnapKit

final class ShipFittingView: UIView {
    
    // MARK: - Private Properties
    private let viewsFactory: ViewsFactoryProtocol
    private var viewModel: ShipFittingViewModel
    
    private lazy var bgImage: UIImageView = {
        return viewsFactory.createBGImageView(for: .main)
    }()
    
    private lazy var shipConfigCollectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ShipsCell.self, forCellWithReuseIdentifier: ShipsCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    // MARK: - Init
    
    init(viewModel: ShipFittingViewModel) {
        self.viewModel = viewModel
        self.viewsFactory = ViewsFactory()
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func reloadData() {
        self.shipConfigCollectionView.reloadData()
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        [bgImage, shipConfigCollectionView].forEach { addSubview($0) }
        
        bgImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        shipConfigCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection in
            switch sectionIndex {
            case 0:
                // Секция с одной ячейкой на всю ширину экрана
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(96)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(96)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 50, trailing: 24)
                return section
                
            case 1...3:
                // Секции со скроллом влево
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(48)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(118), heightDimension: .absolute(48)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 24, trailing: 24)
                section.orthogonalScrollingBehavior = .continuous
                return section
                
            case 4:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(48)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(128), heightDimension: .absolute(48)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 24, bottom: 24, trailing: 24)
                section.orthogonalScrollingBehavior = .continuous
                return section
                
            case 5:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(48)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(150), heightDimension: .absolute(48)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 24, trailing: 24)
                section.orthogonalScrollingBehavior = .continuous
                return section
            default:
                fatalError("configureCollectionViewLayout - Неожиданный индекс секции")
            }
        }
        return layout
    }
}

// MARK: - UICollectionViewDataSource

extension ShipFittingView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShipsCell.reuseIdentifier, for: indexPath) as? ShipsCell else {
            fatalError("Cannot dequeue ShipsCell")
        }
        let shipModel = viewModel.getShipViewModel()!
        cell.configure(with: shipModel)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension ShipFittingView: UICollectionViewDelegate {
}
