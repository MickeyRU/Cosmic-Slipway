import UIKit
import SnapKit
import Combine

final class ShipCell: UICollectionViewCell, BorderConfigurable, ShadowConfigurable {
    
    // MARK: - Public Properties
    
    static let reuseIdentifier = "ShipCell"
    
    let addButtonTapped = PassthroughSubject<Void, Never>()
    let detailsButtonTapped = PassthroughSubject<Void, Never>()
    
    var cancellable: AnyCancellable?
    
    // MARK: - Private Properties
    
    private let viewsFactory: ViewsFactoryProtocol
    
    private lazy var bgView: UIView = {
        return viewsFactory.createBGView(alpha: .mediumTransparent)
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
    
    private var cellButton: UIButton = UIButton(type: .custom)

    private var addShipImageView: UIImageView?
    
    // MARK: - Initializers
    
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
        addBorder(to: self.bgView, cornerRadius: 28,
                  lineWidth: 1,
                  borderColors: [UIColor.active.withAlphaComponent(0.2),
                                 UIColor.pureBlack.withAlphaComponent(0.3)],
                  startPoint: CGPoint(x: 0, y: 0),
                  endPoint: CGPoint(x: 0.3, y: 0.2))
        
        addShadow(to: self.bgView, cornerRadius: 28,
                  shadowColor: UIColor.pureBlack,
                  shadowOpacity: 0.5,
                  shadowOffset: CGSize(width: 0, height: -4),
                  shadowRadius: 4)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancellable?.cancel()
    }
    
    // MARK: - Public Methods
    
    func configure(with viewModel: ShipUIViewModel) {
        shipImageView.image = viewModel.image
        shipTitle.text = viewModel.title
        shipSubTitle.text = viewModel.subTitle
        self.configureButton(for: viewModel.buttonType)
    }
    
    // MARK: - Private Methods
    
    @objc
    private func addButtonPressed() {
        addButtonTapped.send()
    }
    
    @objc
    private func detailsButtonPressed() {
        print("detailsButtonPressed")
        detailsButtonTapped.send()
    }
    
    private func configureButton(for type: ButtonTypes) {
        cellButton.removeTarget(nil, action: nil, for: .allEvents)
        
        viewsFactory.updateButton(cellButton, withType: type)
        
        switch type {
        case .addButton:
            cellButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        case .detailsButton:
            cellButton.addTarget(self, action: #selector(detailsButtonPressed), for: .touchUpInside)
        default:
            break
        }
    }
    
    private func setupViews() {
        [bgView, shipImageView, shipTitle, shipSubTitle, cellButton].forEach { addSubview($0) }
        
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
        
        cellButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(19)
            make.width.height.equalTo(48)
        }
    }
}
