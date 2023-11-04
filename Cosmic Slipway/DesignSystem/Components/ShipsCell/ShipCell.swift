import SnapKit
import UIKit

final class ShipCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    static let reuseIdentifier = "ShipCell"
    
    // MARK: - Private Properties
    
    private let viewsFactory: ViewsFactoryProtocol
    
    private lazy var bgView: UIView = {
        return viewsFactory.createBGView(alpha: .semiTransparent)
    }()
    
    private lazy var shipImageView: UIImageView = {
        return viewsFactory.createShipImageView()
    }()
    
    private lazy var shipTitle: UILabel = {
        return viewsFactory.createTitle(for: .shipTitle)
    }()
    
    private lazy var shipSubTitle: UILabel = {
        return viewsFactory.createTitle(for: .shipDescription)
    }()
    
    private var addShipImageView: UIImageView?
    
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        self.viewsFactory = ViewsFactory()
        super.init(frame: frame)
        
        layer.cornerRadius = 28
        clipsToBounds = true
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configure(with viewModel: ShipUIViewModel) {
        shipImageView.image = viewModel.image
        shipTitle.text = viewModel.title
        shipSubTitle.text = viewModel.subTitle
        
        if let addImage = viewModel.addShipImage {
            let imageView = viewsFactory.createAddShipImage()
            imageView.image = addImage
            
            addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.trailing.equalToSuperview().inset(19)
                make.width.height.equalTo(48)
            }
            
            addShipImageView = imageView
        }
    }
    
    // MARK: - Private Methods
    
    private func layout() {
        [bgView, shipImageView, shipTitle, shipSubTitle].forEach { addSubview($0) }
        
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
        
        shipSubTitle.snp.makeConstraints { make in
            make.leading.equalTo(shipTitle)
            make.bottom.equalTo(shipTitle.snp.top).inset(-6)
        }
    }
}
