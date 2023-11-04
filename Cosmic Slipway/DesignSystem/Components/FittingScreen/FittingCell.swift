import UIKit
import SnapKit

final class FittingCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    static let reuseIdentifier = "FittingCell"
    
    // MARK: - Private Properties
    
    private let viewsFactory: ViewsFactoryProtocol
    
    private let moduleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var bgView: UIView = {
        return viewsFactory.createBGView()
    }()
    
    private lazy var moduleTitle: UILabel = {
        return viewsFactory.createTitle(for: .moduleTitle)
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        self.viewsFactory = ViewsFactory()
        super.init(frame: frame)
        
        layer.cornerRadius = 24
        clipsToBounds = true
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configure(title: String, image: UIImage) {
        self.moduleTitle.text = title
        self.moduleImage.image = image
    }
    
    
    // MARK: - Private Methods
    
    private func setupViews() {
        [bgView, moduleImage, moduleTitle].forEach { addSubview($0) }
        
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        moduleImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(14)
            make.width.height.equalTo(24)
        }
        
        moduleTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(moduleImage.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(14)
        }
    }
}