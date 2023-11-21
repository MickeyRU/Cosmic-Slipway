import UIKit
import Combine

final class HeaderView: UIView, ShadowConfigurable, BorderConfigurable {
    
    // MARK: - Combine Subjects
    
    private let okButtonTappedSubject = PassthroughSubject<Void, Never>()
    private let exitButtonTappedSubject = PassthroughSubject<Void, Never>()
    
    
    // MARK: - Public API for Combine Subjects
    
    var okButtonTappedPublisher: AnyPublisher<Void, Never> {
        return okButtonTappedSubject.eraseToAnyPublisher()
    }
    
    var exitButtonTappedPublisher: AnyPublisher<Void, Never> {
        return exitButtonTappedSubject.eraseToAnyPublisher()
    }
    
    // MARK: - Private Properties
    
    private let viewsFactory: ViewsFactoryProtocol
    
    private var okButton: UIButton = UIButton(type: .custom)
    private var exitButton: UIButton = UIButton(type: .custom)
    
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
        addShadow(to: self.okButton,
                  cornerRadius: 28,
                  shadowColor: HighlightsColors.pureBlack,
                  shadowOpacity: 0.8,
                  shadowOffset: CGSize(width: 0, height: -4),
                  shadowRadius: 16)
        addShadow(to: self.exitButton,
                  cornerRadius: 28,
                  shadowColor: HighlightsColors.pureBlack,
                  shadowOpacity: 0.8,
                  shadowOffset: CGSize(width: 0, height: -4),
                  shadowRadius: 16)
        addBorder(to: self.bgImage,
                  cornerRadius: 28,
                  lineWidth: 1,
                  borderColors: [HighlightsColors.pureBlack,
                                 HighlightsColors.pureBlack],
                  startPoint: CGPoint(x: 0, y: 0),
                  endPoint: CGPoint(x: 1, y: 1))
    }
    
    // MARK: Private methods
    
    @objc
    private func okButtonPressed() {
        okButtonTappedSubject.send()
    }
    
    @objc
    private func exitButtonPressed() {
        exitButtonTappedSubject.send()
    }
    
    private func configureButtons() {
        setupButton(okButton, type: .okButton, action: #selector(okButtonPressed))
        setupButton(exitButton, type: .exitButton, action: #selector(exitButtonPressed))
    }

    private func setupButton(_ button: UIButton, type: ButtonTypes, action: Selector) {
        viewsFactory.updateButton(button, withType: type)
        button.addTarget(self, action: action, for: .touchUpInside)
    }
    
    private func setupViews() {
        [bgImage, okButton, exitButton].forEach { addSubview($0) }
        
        bgImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        okButton.snp.makeConstraints { make in
            make.trailing.equalTo(self).offset(-24)
            make.bottom.equalTo(self).offset(-18)
            make.width.height.equalTo(48)
        }
        
        exitButton.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(24)
            make.bottom.equalTo(self).offset(-18)
            make.width.height.equalTo(48)
        }
    }
}
