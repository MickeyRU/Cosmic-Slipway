import UIKit
import SnapKit

final class ShipSelectionViewController: UIViewController {
    
    private let viewsFactory: ViewsFactoryProtocol
    
    private let backgroundView = BackgroundContainerView(frame: .zero, title: "Select ship type", shipTypesDataArray: ShipDataService.shared.getAllShipTypes())
    
    init(viewsFactory: ViewsFactoryProtocol = ViewsFactory()) {
        self.viewsFactory = viewsFactory
        super.init(nibName: nil, bundle: nil)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        [backgroundView].forEach { view.addSubview($0) }
        
        backgroundView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    }
}
