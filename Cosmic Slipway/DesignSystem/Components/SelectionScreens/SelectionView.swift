import UIKit
import SnapKit

enum BackgroundType {
    case withImageView
    case withoutImageView
}

final class SelectionView<DataType: Nameable>: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Private Properties
    
    private let viewsFactory: ViewsFactoryProtocol
    private let backgroundType: BackgroundType
    private let backgroundImage: BackgroundImageType
    
    private lazy var backgroundView: UIView = {
        switch backgroundType {
        case .withImageView:
            return viewsFactory.createBGView(alpha: .mediumTransparent)
        case .withoutImageView:
            return viewsFactory.createBGView(alpha: .lowTransparent)
        }
    }()
    
    private lazy var titleLabel: UILabel = {
        return viewsFactory.createTitle(for: .shipSelectionPageTitle)
    }()
    
    private lazy var bgImageView: UIImageView = {
        return viewsFactory.createBGImageView(for: backgroundImage)
    }()
    
    private lazy var dataCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SelectionCell.self, forCellWithReuseIdentifier: SelectionCell.reuseIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private var viewModel: SelectionViewModel<DataType>
    
    // MARK: - Initializers
    
    init(frame: CGRect,
         title: String,
         backgroundType: BackgroundType,
         backgroundImage: BackgroundImageType,
         viewsFactory: ViewsFactoryProtocol = ViewsFactory(),
         viewModel: SelectionViewModel<DataType>) {
        self.viewsFactory = viewsFactory
        self.viewModel = viewModel
        self.backgroundType = backgroundType
        self.backgroundImage = backgroundImage
        super.init(frame: frame)
        self.titleLabel.text = title
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupSubviews() {
        switch backgroundType {
        case .withImageView:
            addSubview(bgImageView)
            bgImageView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        case .withoutImageView:
            break
        }
        
        [backgroundView, titleLabel, dataCollectionView].forEach { addSubview($0) }
        
        backgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide).offset(40)
        }
        
        dataCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(48)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-24)
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectionCell.reuseIdentifier, for: indexPath) as? SelectionCell else {
            return UICollectionViewCell()
        }
        let shipType = viewModel.data[indexPath.item]
        cell.setupCell(title: shipType.name)
        return cell
    }
    
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItemAt(index: indexPath.row)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellInserts = UIEdgeInsets(top: 0, left: 48, bottom: 0, right: 48)
        let width = frame.width - (cellInserts.left + cellInserts.right)
        return CGSize(width: width, height: 48)
    }
}
