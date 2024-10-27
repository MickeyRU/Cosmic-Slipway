import UIKit

final class DefenseDetailView: UIView, ConfigurableDetailView {
    private let viewFactory: DetailsViewFactoryProtocol

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
        [].forEach { addSubview($0) }
        
       
    }
}
