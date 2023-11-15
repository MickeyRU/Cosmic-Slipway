import UIKit
import SnapKit

final class SelectionCell: UICollectionViewCell, BorderConfigurable {
    
    // MARK: - Public Properties
    
    static let reuseIdentifier = "SelectionCell"
    
    // MARK: - Private Properties
    
    private let viewsFactory: ViewsFactoryProtocol
    
    private lazy var cellLabel: UILabel = {
        return viewsFactory.createTitle(for: .shipTypeInCell)
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

    override func layoutSubviews() {
        super.layoutSubviews()
        
        addBorder(to: self,
                  cornerRadius: 24,
                  lineWidth: 2,
                  borderColors: HighlightsColors.gradient,
                  startPoint: CGPoint(x: 0.9, y: 0),
                  endPoint: CGPoint(x: 0.1, y: 1))
    }
    
    // MARK: - Public Methods
    
    func setupCell(title: String) {
        self.cellLabel.text = title
    }
    
    // MARK: - Private Methods
    
    private func layout() {
        [cellLabel].forEach { contentView.addSubview($0) }
        
        cellLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(17)
            make.trailing.equalToSuperview().offset(-17)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
}
