import Foundation

final class ShipCreatingService {
    private var shipTypes: [ShipType] = []
    private var shipSubTypes: [ShipSubtype] = []
    private var ships: [Ship] = []
    private var ship: Ship?
    
    init() {
        self.shipTypes = MockDataService.shared.loadMockShipTypesData()
    }
    
    func getShipTypesList() -> [ShipType] {
        return shipTypes
    }
    
    func getShipSubtypesList(for shipTypeID: UUID) -> [ShipSubtype] {
        self.shipSubTypes = shipTypes.first(where: { $0.id == shipTypeID })?.subTypes ?? []
        return shipSubTypes
    }
    
    func getShipsList(for shipSubTypeID: UUID) -> [Ship] {
        self.ships = self.shipSubTypes.first(where: { $0.id == shipSubTypeID })?.ships ?? []
        return ships
    }
    
    func getShip(by shipID: UUID) -> Ship? {
        self.ship = ships.first(where: { $0.id == shipID }) ?? nil
        return ship
    }
    
    func prepareShipForSave(ship: Ship) -> Ship {
        let shipWithNewID = Ship(id: UUID(),
                           name: ship.name,
                           shipImage: ship.shipImage,
                           fitting: ship.fitting)
        return shipWithNewID
    }
}
