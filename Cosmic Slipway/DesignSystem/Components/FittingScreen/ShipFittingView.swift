import UIKit
import SnapKit
import Combine

final class ShipFittingView: UIView {
    
    // MARK: - Private Properties
    
    private let viewsFactory: ViewsFactoryProtocol
    private let viewModel: ShipFittingViewModel
    private let headerView: HeaderView
    
    private lazy var bgImage: UIImageView = {
        return viewsFactory.createBGImageView(for: .main)
    }()
    
    private lazy var shipConfigCollectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ShipCell.self, forCellWithReuseIdentifier: ShipCell.reuseIdentifier)
        collectionView.register(FittingCell.self, forCellWithReuseIdentifier: FittingCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        return collectionView
    }()
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(viewModel: ShipFittingViewModel, headerView: HeaderView = HeaderView()) {
        self.viewModel = viewModel
        self.headerView = headerView
        self.viewsFactory = ViewsFactory()
        super.init(frame: .zero)
        setupViews()
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func reloadData() {
        self.shipConfigCollectionView.reloadData()
    }
    
    // MARK: - Private Methods
    
    private func setupBindings() {
        headerView.okButtonTappedPublisher
            .sink { [weak viewModel] in viewModel?.okButtonTapped.send() }
            .store(in: &cancellables)
        
        headerView.exitButtonTappedPublisher
            .sink { [weak viewModel] in viewModel?.exitButtonTapped.send() }
            .store(in: &cancellables)
    }
    
    private func setupViews() {
        [bgImage, headerView, shipConfigCollectionView].forEach { addSubview($0) }
        
        bgImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(128)
        }
        
        shipConfigCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(headerView.snp.bottom)
        }
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            
            switch sectionIndex {
            case 0:
                return self.fullWidthSection()
            case 1...3:
                return self.scrollingSection(itemHeight: 48, groupWidth: 118)
            case 4:
                return self.scrollingSection(itemHeight: 48, groupWidth: 128)
            case 5:
                return self.scrollingSection(itemHeight: 48, groupWidth: 150)
            default:
                fatalError("Unexpected section index")
            }
        }
    }
    
    private func fullWidthSection() -> NSCollectionLayoutSection {
        let item = createItem(width: .fractionalWidth(1), height: .absolute(96))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(96)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 50, trailing: 24)
        return section
    }
    
    private func scrollingSection(itemHeight: CGFloat, groupWidth: CGFloat) -> NSCollectionLayoutSection {
        let item = createItem(width: .fractionalWidth(1), height: .absolute(itemHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(groupWidth), heightDimension: .absolute(itemHeight)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 24, trailing: 24)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func createItem(width: NSCollectionLayoutDimension, height: NSCollectionLayoutDimension) -> NSCollectionLayoutItem {
        return NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: width,
                                                                         heightDimension: height))
    }
    
}

// MARK: - UICollectionViewDataSource

extension ShipFittingView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let ship = viewModel.ship.value else {
            return 0
        }
        
        switch section {
        case 1:
            return ship.fitting.maxHighSlots
        case 2:
            return ship.fitting.maxMidSlots
        case 3:
            return ship.fitting.maxLowSlots
        case 4:
            return ship.fitting.maxCombatRigs
        case 5:
            return ship.fitting.maxEngineeringRigs
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Unexpected section index")
        }
        
        switch section {
        case .selectedShip:
            let cell = collectionView.dequeueReusableCell(withType: ShipCell.self, for: indexPath)
            let shipModel = viewModel.getShipViewModel()!
            cell.configure(with: shipModel)
            return cell
        case .highSlot, .midSlot, .lowSlot, .combatRig, .engineeringRig:
            let (title, image) = section.titleAndImage()
            let cell = collectionView.dequeueReusableCell(withType: FittingCell.self, for: indexPath)
            cell.configure(title: title, image: image)
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate

extension ShipFittingView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Unexpected section index")
        }
        let slot: ModuleSlot
        
        switch section {
        case .highSlot:
            slot = .high
        case .midSlot:
            slot = .mid
        case .lowSlot:
            slot = .low
        case .combatRig:
            slot = .combatRig
        case .engineeringRig:
            slot = .engineeringRig
        default:
            return
        }
        
        let selection = ModuleSelection(slot: slot, indexPath: indexPath)
        viewModel.didSelectModuleSlot.send(selection)
    }
}
