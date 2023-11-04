import UIKit
import Combine

final class HeaderView: UIView {
    
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
    
    private lazy var bgImage: UIView = {
        let view = viewsFactory.createBGView(alpha: .moreTransparent)
        view.layer.cornerRadius = 28
        return view
    }()
    
    private lazy var okButton = {
        let button = viewsFactory.createButton(type: .okButton)
        button.addTarget(self, action: #selector(okButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var exitButton = {
        let button = viewsFactory.createButton(type: .exitButton)
        button.addTarget(self, action: #selector(exitButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    
    init() {
        self.viewsFactory = ViewsFactory()
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

