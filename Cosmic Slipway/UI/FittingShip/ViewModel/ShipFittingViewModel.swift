import Combine
import UIKit

final class ShipFittingViewModel {
    var ship: CurrentValueSubject<Ship?, Never>
    
    init(shipID: UUID) {
        ship = CurrentValueSubject(nil)
        loadShip(with: shipID)
    }
    
    private func loadShip(with shipID: UUID) {
        self.ship.value = ShipDataService.shared.getShip(byID: shipID)
    }
    
    func getShipViewModel() -> ShipUIViewModel? {
        guard let currentShip = ship.value else {
            return nil
        }
        
        return ShipUIViewModel(image: UIImage(named: currentShip.shipImage)!,
                               title: currentShip.name,
                               subTitle: "Your Ship",
                               addShipImage: nil)
    }
}
