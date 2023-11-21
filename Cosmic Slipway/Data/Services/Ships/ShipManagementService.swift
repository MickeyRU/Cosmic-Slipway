import Foundation
import Combine

class ShipManagementService {
    
    // MARK: - Public Properties
    
    static let shared = ShipManagementService()
    
    var userShipsPublisher: AnyPublisher<[Ship], Never> {
        userShipsSubject.eraseToAnyPublisher()
    }
    
    // MARK: - Private Properties
    
    private let shipCreatingService: ShipCreatingService
    
    private var userShipsSubject = CurrentValueSubject<[Ship], Never>([])
    
    // MARK: - Initialaizer
    
    init(shipCreatingService: ShipCreatingService = ShipCreatingService()) {
        self.shipCreatingService = shipCreatingService
    }
    
    // MARK: - Public Methods of creating a new ship
    
    func loadShipTypesList() -> [ShipType] {
        return shipCreatingService.getShipTypesList()
    }
    
    func loadShipSubtypesList(for shipTypeID: UUID) -> [ShipSubtype] {
        return shipCreatingService.getShipSubtypesList(for: shipTypeID)
    }
    
    func loadShipsList(for shipSubTypeID: UUID) -> [Ship] {
        return shipCreatingService.getShipsList(for: shipSubTypeID)
    }
    
    func loadShip(by shipID: UUID) -> Ship? {
        return shipCreatingService.getShip(by: shipID)
    }
    
    func saveNewShip(ship: Ship) {
        let shipForSave = shipCreatingService.prepareShipForSave(ship: ship)
        self.userShipsSubject.value.append(shipForSave)
    }
    
    // MARK: - Public Methods of editing user ship
    
    func loadShipForEditing(with shipID: UUID) -> Ship? {
        guard let shipForEditing = self.userShipsSubject.value.first(where: { $0.id == shipID }) else { return nil }
        // Нужно передать корабль для редактирования в сервис
        return shipForEditing
    }
    
    func saveEditedShip(ship: Ship) {
        guard let index = self.userShipsSubject.value.firstIndex(where: { $0.id == ship.id }) else { return }
        self.userShipsSubject.value[index] = ship
        // Отправляем обновленный список кораблей всем подписчикам
        userShipsSubject.send(self.userShipsSubject.value)
    }
}
