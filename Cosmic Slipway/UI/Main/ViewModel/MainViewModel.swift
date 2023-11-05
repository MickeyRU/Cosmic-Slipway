import UIKit
import Combine

protocol MainViewModelProtocol {
    var ships: [Ship] { get}
    var shipsPublisher: AnyPublisher<[Ship], Never> { get }
    
    func getShipViewModel(at index: Int) -> ShipUIViewModel
}

final class MainViewModel: ObservableObject, MainViewModelProtocol {
    @Published private (set) var ships: [Ship] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    var shipsPublisher: AnyPublisher<[Ship], Never> {
        $ships.eraseToAnyPublisher()
    }
    
    init() {
        ShipManagementService.shared.userShipsPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] updatedShips in
                guard let self = self else { return }
                self.ships = updatedShips
            }
            .store(in: &cancellables)
    }
    
    func getShipViewModel(at index: Int) -> ShipUIViewModel {
        if index == 0 {
            return ShipUIViewModel(image: ShipImages.defaultShipImage,
                                   title: "New ship",
                                   subTitle: "Configure",
                                   addShipImage: NavigationImages.addButtonImage)
        } else {
            let ship = ships[index - 1]
            // Здесь предполагается, что у вас есть способ получения изображения из названия
            let image = UIImage(named: ship.shipImage) ?? ShipImages.defaultShipImage
            return ShipUIViewModel(image: image,
                                   title: ship.name,
                                   subTitle: "Your Configuration",
                                   addShipImage: nil)
        }
    }
}
