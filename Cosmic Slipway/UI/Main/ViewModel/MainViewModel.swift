import UIKit
import Combine

enum ShipCellType {
    case newShip
    case existedShip
}

protocol MainViewModelProtocol {
    var ships: [Ship] { get}
    var shipsPublisher: AnyPublisher<[Ship], Never> { get } 
    
    func getShipViewModel(cellType: ShipCellType) -> ShipUIViewModel 
}

final class MainViewModel: ObservableObject, MainViewModelProtocol {
    @Published private (set) var ships: [Ship] = []
    
    var shipsPublisher: AnyPublisher<[Ship], Never> {
        $ships.eraseToAnyPublisher()  
    }
    
    func getShipViewModel(cellType: ShipCellType) -> ShipUIViewModel {
        switch cellType {
        case .newShip:
            return ShipUIViewModel(image: ShipImages.defaultShipImage,
                                 title: "New ship",
                                 subTitle: "Configure",
                                 addShipImage:  NavigationImages.addButtonImage)
        case .existedShip:
            print("Настройте в модели existedShip")
            return ShipUIViewModel(image: ShipImages.defaultShipImage,
                                 title: "New ship",
                                 subTitle: "Configure",
                                 addShipImage:  NavigationImages.addButtonImage)
        }
    }
}
