import UIKit
import SnapKit

final class BackgroundContainerView<DataType: Nameable>: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Private Properties
    
    private let viewsFactory: ViewsFactoryProtocol
    
    private let backgroundView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = BasicColors.colorWithAlpha(BasicColors.darkBG, withAlpha: 0.7)
        return bgView
    }()
    
    private lazy var titleLabel: UILabel = {
        return viewsFactory.createTitle(for: .shipSelectionPageTitle)
    }()
    
    private lazy var bgImageView: UIImageView = {
        return viewsFactory.createBGImageView(for: .shipSelection)
    }()
    
    private lazy var shipTypeCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UniversalSelectionShipTypeCell.self, forCellWithReuseIdentifier: UniversalSelectionShipTypeCell.reuseIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private var viewModel: BackgroundContainerViewModel<DataType>
    
    // MARK: - Initializers
    
    init(frame: CGRect,
         title: String,
         viewsFactory: ViewsFactoryProtocol = ViewsFactory(),
         viewModel: BackgroundContainerViewModel<DataType>) {
        self.viewsFactory = viewsFactory
        self.viewModel = viewModel
        super.init(frame: frame)
        self.titleLabel.text = title
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupSubviews() {
        [bgImageView, backgroundView, titleLabel, shipTypeCollectionView].forEach { addSubview($0) }
        
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide).offset(40)
        }
        
        shipTypeCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(48)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-24)
        }
    }
    
    
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.shipsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UniversalSelectionShipTypeCell.reuseIdentifier, for: indexPath) as? UniversalSelectionShipTypeCell else {
            return UICollectionViewCell()
        }
        let shipType = viewModel.shipsData[indexPath.item]
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
