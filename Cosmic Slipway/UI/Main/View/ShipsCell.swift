import SnapKit
import UIKit

final class ShipsCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    static let reuseIdentifier = "ShipsCell"
    
    // MARK: - Private Properties
    
    private let viewsFactory: ViewsFactoryProtocol
    
    private lazy var bgView: UIView = {
        return viewsFactory.createBGView()
    }()
    
    private lazy var shipImageView: UIImageView = {
        return viewsFactory.createShipImageView()
    }()
    
    private lazy var shipTitle: UILabel = {
        return viewsFactory.createTitle(for: .shipTitle)
    }()
    
    private lazy var shipStatusTitle: UILabel = {
        return viewsFactory.createTitle(for: .shipDescription)
    }()
    
    private lazy var addShipImage: UIImageView = {
        return viewsFactory.createAddShipImage()
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
    
    // MARK: - Private Methods
    
    private func layout() {
        [bgView, shipImageView, shipTitle, shipStatusTitle, addShipImage].forEach { addSubview($0) }
        
        bgView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        shipImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(18)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(60)
        }
        
        shipTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(35)
        }
        
        shipStatusTitle.snp.makeConstraints { make in
            make.leading.equalTo(shipTitle)
            make.bottom.equalTo(shipTitle.snp.top).inset(-6)
        }
        
        addShipImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(19)
            make.width.height.equalTo(48)
        }
    }
}
