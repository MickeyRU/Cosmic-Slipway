import UIKit
import Combine

final class MainHeaderView: UIView, ShadowConfigurable, BorderConfigurable {
    
    // MARK: - Combine Subjects
    
    private let profileButtonTappedSubject = PassthroughSubject<Void, Never>()
    
    // MARK: - Public API for Combine Subjects
    
    var profileButtonTappedPublisher: AnyPublisher<Void, Never> {
        return profileButtonTappedSubject.eraseToAnyPublisher()
    }
    
    // MARK: - Private Properties
    
    private let viewsFactory: ViewsFactoryProtocol
    
    private var profileButton: UIButton = UIButton(type: .custom)
    
    private lazy var bgImage: UIView = {
        let view = viewsFactory.createBGView(alpha: .heavyTransparent)
        view.layer.cornerRadius = 28
        return view
    }()
        
    // MARK: - Init
    
    init() {
        self.viewsFactory = ViewsFactory()
        super.init(frame: .zero)
        setupViews()
        configureButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addShadow(to: self.profileButton,
                  cornerRadius: 28,
                  shadowColor: UIColor.pureBlack,
                  shadowOpacity: 0.8,
                  shadowOffset: CGSize(width: 0, height: -4),
                  shadowRadius: 16)
        addBorder(to: self.bgImage,
                  cornerRadius: 28,
                  lineWidth: 1,
                  borderColors: [UIColor.pureBlack,
                                 UIColor.pureBlack],
                  startPoint: CGPoint(x: 0, y: 0),
                  endPoint: CGPoint(x: 1, y: 1))
    }
    
    // MARK: Private methods
    
    @objc
    private func profileButtonPressed() {
        profileButtonTappedSubject.send()
    }
    
    
    private func configureButtons() {
        setupButton(profileButton, type: .profileButton, action: #selector(profileButtonPressed))
    }

    private func setupButton(_ button: UIButton, type: ButtonTypes, action: Selector) {
        viewsFactory.updateButton(button, withType: type)
        button.addTarget(self, action: action, for: .touchUpInside)
    }
    
    private func setupViews() {
        [bgImage, profileButton].forEach { addSubview($0) }
        
        bgImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        profileButton.snp.makeConstraints { make in
            make.trailing.equalTo(self).offset(-24)
            make.bottom.equalTo(self).offset(-18)
            make.width.height.equalTo(48)
        }
    }
}
