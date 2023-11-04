import UIKit
import SnapKit

final class UniversalSelectionShipTypeCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    static let reuseIdentifier = "UniversalSelectionShipTypeCell"
    
    // MARK: - Private Properties
    
    private let viewsFactory: ViewsFactoryProtocol
    
    private let backBorderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = BgImages.backBorderImage
        return imageView
    }()
    
    private lazy var cellLabel: UILabel = {
        return viewsFactory.createTitle(for: .shipTypeInCell)
    }()
    
    // MARK: - Initializers
        
    override init(frame: CGRect) {
        self.viewsFactory = ViewsFactory()
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func setupCell(title: String) {
        self.cellLabel.text = title
    }
    
    // MARK: - Private Methods
    
    private func layout() {
        [backBorderImageView, cellLabel].forEach { contentView.addSubview($0) }
        
        backBorderImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        cellLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalTo(backBorderImageView).offset(17)
            make.trailing.equalTo(backBorderImageView).offset(-17)
            make.centerY.equalToSuperview()
        }
    }
}
