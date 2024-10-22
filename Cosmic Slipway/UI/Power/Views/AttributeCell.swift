import UIKit
import SnapKit

final class AttributeCell: UICollectionViewCell, ShadowConfigurable, BorderConfigurable {
    static let reuseIdentifier = "AttributeCell"
    
    private let viewsFactory: ViewsFactoryProtocol
    
    private lazy var bgView: UIView = {
        return viewsFactory.createBGView(alpha: .mediumTransparent)
    }()
    
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .offenseIcon
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let cellTitle: UILabel = {
        let label = UILabel()
        label.font = AppFonts.figtreeExBold16.uiKitFont()
        label.textColor = .active
        return label
    }()
    
    private let cellSubTitle: UILabel = {
        let label = UILabel()
        label.font = AppFonts.figtreeRegular10.uiKitFont()
        label.textColor = .iconText
        return label
    }()
    
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let cellValueTitle: UILabel = {
        let label = UILabel()
        label.font = AppFonts.figtreeExBold24.uiKitFont()
        label.textColor = .active
        label.textAlignment = .center
        label.text = "17 223.43"
        return label
    }()
    
    private let titleInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var detailView: ConfigurableDetailView?
    
    override init(frame: CGRect) {
        self.viewsFactory = ViewsFactory()
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addBorder(to: self.contentView, cornerRadius: 11,
                  lineWidth: 1,
                  borderColors: [UIColor.active.withAlphaComponent(0.2),
                                 UIColor.pureBlack.withAlphaComponent(0.3)],
                  startPoint: CGPoint(x: 0, y: 0),
                  endPoint: CGPoint(x: 0.3, y: 0.2))
        
        addShadow(to: self.contentView, cornerRadius: 11,
                  shadowColor: UIColor.pureBlack,
                  shadowOpacity: 0.5,
                  shadowOffset: CGSize(width: 4, height: -4),
                  shadowRadius: 4)
    }
    
    func configure(with configuration: AttributeCellConfiguration) {
        self.cellImageView.image = configuration.type.image
        self.cellTitle.text = configuration.type.title
        self.cellSubTitle.text = configuration.type.subtitle
                
        switch configuration.type {
        case .offense:
            self.detailView = OffenseDetailView()
        case .defense:
            self.detailView = OffenseDetailView()
        case .capacitor:
            self.detailView = OffenseDetailView()
        case .targeting:
            self.detailView = OffenseDetailView()
        case .navigation:
            self.detailView = OffenseDetailView()
        }
        
        guard let detailView = self.detailView else {
            return
        }
        contentView.addSubview(detailView)
        detailView.snp.makeConstraints { make in
            make.top.equalTo(titleStackView.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview().inset(18)
        }
    }
    private func setupViews() {
        [cellTitle, cellSubTitle].forEach { titleStackView.addArrangedSubview($0) }
        [titleStackView, cellValueTitle].forEach { titleInfoStackView.addArrangedSubview($0)}
        [bgView, cellImageView, titleInfoStackView].forEach { contentView.addSubview($0) }
        
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        cellImageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(18)
            make.width.height.equalTo(40)
        }
        
        titleInfoStackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(cellImageView)
            make.leading.equalTo(cellImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(58)
        }
    }
}
