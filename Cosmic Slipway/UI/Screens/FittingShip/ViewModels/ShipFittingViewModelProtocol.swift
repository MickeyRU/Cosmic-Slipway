import UIKit
import Combine

protocol ShipFittingViewModelProtocol: AnyObject {
    var okButtonTapped: PassthroughSubject<Void, Never> { get }
    var exitButtonTapped: PassthroughSubject<Void, Never> { get }
    var slotForFitting: PassthroughSubject<SlotAndIndex, Never> { get }
    var moduleType: PassthroughSubject<Void, Never> { get }
    var ship: CurrentValueSubject<Ship?, Never> { get }
    
    func getShipViewModel() -> ShipUIViewModel?
}

extension ShipFittingViewModelProtocol {
    func getShipViewModel() -> ShipUIViewModel? {
        guard
            let currentShip = ship.value,
            let image = UIImage(named: currentShip.shipImage)
        else { return nil }
        
        return ShipUIViewModel(image: image,
                               title: currentShip.name,
                               subTitle: "Your Ship",
                               buttonType: .detailsButton)
    }
}
