import UIKit

final class ShipFittingViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let ship: UUID
    
    // MARK: - Init
    
    init(shipID: UUID) {
        self.ship = shipID
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .red

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
}
