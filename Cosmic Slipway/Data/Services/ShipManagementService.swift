import Foundation
import Combine

class ShipManagementService {
    
    // MARK: - Public Properties
    
    static let shared = ShipManagementService()
    
    var userShipsPublisher: AnyPublisher<[Ship], Never> {
        userShipsSubject.eraseToAnyPublisher()
    }
    
    // MARK: - Private Properties
    
    private var userShipsSubject = CurrentValueSubject<[Ship], Never>([])
    
    private var shipTypes: [ShipType] = []
    private var shipSubTypes: [ShipSubtype] = []
    private var ships: [Ship] = []
    private var userShips: [Ship] = []
    
    // MARK: - Init
    
    private init() {
        self.shipTypes = MockDataService.shared.loadMockShipsData()
    }
    
    // MARK: - Public Methods

    func getAllShipTypes() -> [ShipType] {
        return shipTypes
    }
    
    func getShipSubtypes(forShipTypeID shipTypeID: UUID) -> [ShipSubtype] {
        self.shipSubTypes = shipTypes.first(where: { $0.id == shipTypeID })?.subTypes ?? []
        return shipSubTypes
    }
    
    func getShips(forShipSubTypeID shipSubTypeID: UUID) -> [Ship] {
        self.ships = self.shipSubTypes.first(where: { $0.id == shipSubTypeID })?.ships ?? []
        return ships
    }
    
    func getShip(byID: UUID) -> Ship {
        guard let ship = ships.first(where: {$0.id == byID }) else {
            print("Ошибка получения корабля")
            fatalError()
        }
        return ship
    }
    
    func saveUserShip(_ ship: Ship) {
        if let index = userShips.firstIndex(where: { $0.configurationID == ship.configurationID }) {
            userShips[index] = ship // Обновляем существующую конфигурацию
        } else {
            userShips.append(ship) // Добавляем новую конфигурацию
        }
        userShipsSubject.send(self.userShips)
    }
    
    // MARK: - Private Methods
}
