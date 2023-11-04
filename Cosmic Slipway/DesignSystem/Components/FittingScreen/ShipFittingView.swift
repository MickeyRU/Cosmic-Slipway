import UIKit
import SnapKit

final class ShipFittingView: UIView {
        
    // MARK: - Private Properties
    private let viewsFactory: ViewsFactoryProtocol
    
    private lazy var bgImage: UIImageView = {
        return viewsFactory.createBGImageView(for: .main)
    }()
    
//    let shipConfigCollectionView: UICollectionView = {
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
//        collectionView.register(ShipSelectedCell.self, forCellWithReuseIdentifier: ShipSelectedCell.reuseIdentifier)
//        collectionView.register(FittingCell.self, forCellWithReuseIdentifier: FittingCell.reuseIdentifier)
//        collectionView.backgroundColor = .clear
//        return collectionView
//    }()
    
    // MARK: - Init
        
    override init(frame: CGRect) {
        self.viewsFactory = ViewsFactory()
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Private Methods
    
    private func setupViews() {
        [bgImage].forEach { addSubview($0) }
        
        bgImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
//    private func configureCollectionViewLayout() {
//        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection in
//            switch sectionIndex {
//            case 0:
//                // Секция с одной ячейкой на всю ширину экрана
//                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(96)))
//                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(96)), subitems: [item])
//                let section = NSCollectionLayoutSection(group: group)
//                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 50, trailing: 24)
//                return section
//                
//            case 1...3:
//                // Секции со скроллом влево
//                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(48)))
//                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(118), heightDimension: .absolute(48)), subitems: [item])
//                let section = NSCollectionLayoutSection(group: group)
//                section.interGroupSpacing = 10
//                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 24, trailing: 24)
//                section.orthogonalScrollingBehavior = .continuous
//                return section
//                
//            case 4:
//                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(48)))
//                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(128), heightDimension: .absolute(48)), subitems: [item])
//                let section = NSCollectionLayoutSection(group: group)
//                section.interGroupSpacing = 10
//                section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 24, bottom: 24, trailing: 24)
//                section.orthogonalScrollingBehavior = .continuous
//                return section
//                
//            case 5:
//                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(48)))
//                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(150), heightDimension: .absolute(48)), subitems: [item])
//                let section = NSCollectionLayoutSection(group: group)
//                section.interGroupSpacing = 10
//                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 24, trailing: 24)
//                section.orthogonalScrollingBehavior = .continuous
//                return section
//            default:
//                fatalError("configureCollectionViewLayout - Неожиданный индекс секции")
//            }
//        }
//        shipConfigCollectionView.collectionViewLayout = layout
//    }
}
