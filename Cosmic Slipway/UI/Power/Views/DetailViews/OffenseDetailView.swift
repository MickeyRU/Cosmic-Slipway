import UIKit

final class OffenseDetailView: UIView, ConfigurableDetailView {
    private let viewFactory: DetailsViewFactoryProtocol
    
    private lazy var turretsImageView = viewFactory.createImageView(withImageName: .offenseTurretsIcon)
    private lazy var missleImageView = viewFactory.createImageView(withImageName: .offenseMissilesIcon)
    private lazy var droneImageView = viewFactory.createImageView(withImageName: .offenseDroneIcon)
    
    private lazy var turrentsTitle = viewFactory.createLabel(withText: NSLocalizedString("turrets", 
                                                                                         tableName: "PowerLocalization",
                                                                                         comment: ""),
                                                             font: AppFonts.figtreeRegular12,
                                                             textColor: .iconText, aligment: .left)
    private lazy var misslesTitle = viewFactory.createLabel(withText: NSLocalizedString("missles",
                                                                                         tableName: "PowerLocalization",
                                                                                         comment: ""),
                                                            font: AppFonts.figtreeRegular12,
                                                             textColor: .iconText, aligment: .left)
    private lazy var dronesTitle = viewFactory.createLabel(withText: NSLocalizedString("drones",
                                                                                       tableName: "PowerLocalization",
                                                                                       comment: ""),
                                                           font: AppFonts.figtreeRegular12,
                                                           textColor: .iconText, aligment: .left)
    
    private lazy var turrentsDpsTitle = viewFactory.createLabel(withText: "199 131.10 DPS",
                                                                font: AppFonts.figtreeExBold16,
                                                                textColor: .active, aligment: .center)
    private lazy var misslesDpsTitle = viewFactory.createLabel(withText: "1 131.10 DPS",
                                                               font: AppFonts.figtreeExBold16,
                                                                textColor: .active, aligment: .center)
    private lazy var dronesDpsTitle = viewFactory.createLabel(withText: "1 131.10 DPS",
                                                              font: AppFonts.figtreeExBold16,
                                                              textColor: .active, aligment: .center)
    
    private lazy var dpsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView

    }()

    init(viewFactory: DetailsViewFactoryProtocol = DetailsViewFactory(), frame: CGRect = .zero) {
        self.viewFactory = viewFactory
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with data: DetailViewUIModelProtocol) {
    }
    
    private func setupViews() {
        [turrentsDpsTitle, misslesDpsTitle, dronesDpsTitle].forEach { dpsStackView.addArrangedSubview($0) }
        [turrentsTitle, misslesTitle, dronesTitle, turretsImageView, missleImageView, droneImageView, dpsStackView].forEach { addSubview($0) }
        
        turrentsTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.leading.equalToSuperview().inset(20)
        }
        
        misslesTitle.snp.makeConstraints { make in
            make.top.equalTo(turrentsTitle)
            make.centerX.equalToSuperview()
        }
        
        dronesTitle.snp.makeConstraints { make in
            make.top.equalTo(turrentsTitle)
            make.trailing.equalToSuperview().inset(20)
        }
     
        turretsImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalTo(turrentsTitle)
            make.width.height.equalTo(30)
        }
        
        missleImageView.snp.makeConstraints { make in
            make.top.equalTo(turretsImageView)
            make.centerX.equalTo(misslesTitle)
            make.width.height.equalTo(30)
        }
        
        droneImageView.snp.makeConstraints { make in
            make.top.equalTo(turretsImageView)
            make.centerX.equalTo(dronesTitle)
            make.width.height.equalTo(30)
        }
        
        dpsStackView.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
}
