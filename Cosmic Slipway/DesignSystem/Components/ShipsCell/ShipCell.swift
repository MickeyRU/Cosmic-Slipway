import UIKit
import SnapKit

final class ShipCell: UICollectionViewCell, BorderConfigurable, ShadowConfigurable {
    
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
        
        setupViews()
        setupAddShipImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addBorder(to: self.bgView, cornerRadius: 28,
                  lineWidth: 1,
                  borderColors: [BasicColors.colorWithAlpha(BasicColors.active, withAlpha: 0.2),
                                 BasicColors.colorWithAlpha(HighlightsColors.pureBlack, withAlpha: 0.3)],
                  startPoint: CGPoint(x: 0, y: 0),
                  endPoint: CGPoint(x: 0.3, y: 0.2))
        
        addShadow(to: self.bgView, cornerRadius: 28,
                  shadowColor: HighlightsColors.pureBlack,
                  shadowOpacity: 0.8,
                  shadowOffset: CGSize(width: 0, height: -4),
                  shadowRadius: 4)
    }
    
    // MARK: - Public Methods
    
    func configure(with viewModel: ShipUIViewModel) {
        shipImageView.image = viewModel.image
        shipTitle.text = viewModel.title
        shipSubTitle.text = viewModel.subTitle
        
        // Configure addShipImageView only if addImage is available
        addShipImageView?.image = viewModel.addShipImage
        addShipImageView?.isHidden = viewModel.addShipImage == nil
    }
    
    // MARK: - Private Methods
    
    private func setupAddShipImageView() {
        let imageView = viewsFactory.createAddShipImage()
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(19)
            make.width.height.equalTo(48)
        }
        addShipImageView = imageView
    }
    
    private func setupViews() {
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
