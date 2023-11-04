import UIKit
import SnapKit

enum Section: Int, CaseIterable {
    case selectedShip = 0
    case highSlot
    case midSlot
    case lowSlot
    case combatRig
    case engineeringRig
    
    func titleAndImage() -> (title: String, image: UIImage) {
        switch self {
        case .highSlot:
            return ("High Slot", ModuleImages.highSlotClean)
        case .midSlot:
            return ("Mid Slot", ModuleImages.midSlotClean)
        case .lowSlot:
            return ("Low Slot", ModuleImages.lowSlotClean)
        case .combatRig:
            return ("Combat Rig", ModuleImages.combatRigClean)
        case .engineeringRig:
            return ("Engineering Rig", ModuleImages.engineerRigsClean)
        default:
            return ("", UIImage())
        }
    }
}

final class ShipFittingView: UIView {
    
    // MARK: - Private Properties
    private let viewsFactory: ViewsFactoryProtocol
    private var viewModel: ShipFittingViewModel
    
    private lazy var bgImage: UIImageView = {
        return viewsFactory.createBGImageView(for: .main)
    }()
    
    private lazy var okButton = {
        let button = viewsFactory.createButton(type: .okButton)
        button.addTarget(self, action: #selector(okButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var exitButton = {
        let button = viewsFactory.createButton(type: .exitButton)
        button.addTarget(self, action: #selector(exitButtonPressed), for: .touchUpInside)
        return button    }()
    
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
    
    @objc
    private func okButtonPressed() {
        viewModel.okButtonTapped.send()
    }
    
    @objc
    private func exitButtonPressed() {
        viewModel.exitButtonTapped.send()
    }
    
    private func setupViews() {
        [bgImage, okButton, exitButton, shipConfigCollectionView].forEach { addSubview($0) }
        
        bgImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        okButton.snp.makeConstraints { make in
            make.trailing.equalTo(self).offset(-24)
            make.top.equalTo(safeAreaLayoutGuide)
            make.width.height.equalTo(48)
        }
        
        exitButton.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(24)
            make.top.equalTo(safeAreaLayoutGuide)
            make.width.height.equalTo(48)
        }
        
        shipConfigCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(okButton.snp.bottom)
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
        return NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: width, heightDimension: height))
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
            return ship.fitting.highSlots
        case 2:
            return ship.fitting.midSlots
        case 3:
            return ship.fitting.lowSlots
        case 4:
            return ship.fitting.combatRigs
        case 5:
            return ship.fitting.engineeringRigs
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
    
}
