import Foundation

class ShipDataService {
    static let shared = ShipDataService()
    
    // Массивы для хранения данных о кораблях
    private var shipTypes: [ShipType]
    private var shipSubtypes: [ShipSubtype]
    private var ships: [Ship]
    
    private init() {
        // Инициализация массивов данными, например, заглушками
        self.shipTypes = [
            ShipType(id: 1, name: "Type 1", subtypes: []),
            ShipType(id: 2, name: "Type 2", subtypes: [])
        ]
        
        self.shipSubtypes = [
            ShipSubtype(id: 1, name: "Subtype 1", ships: []),
            ShipSubtype(id: 2, name: "Subtype 2", ships: [])
        ]
        
        self.ships = [
            Ship(id: 1, name: "Ship 1", shipImage: "ship1", fitting: Fitting(highSlots: 4, midSlots: 3, lowSlots: 5, combatRigs: 2, engineeringRigs: 1)),
            Ship(id: 2, name: "Ship 2", shipImage: "ship2", fitting: Fitting(highSlots: 5, midSlots: 4, lowSlots: 3, combatRigs: 1, engineeringRigs: 2))
        ]
    }
    
    func getAllShipTypes() -> [ShipType] {
        return shipTypes
    }
    
    func getAllShipSubtypes() -> [ShipSubtype] {
        return shipSubtypes
    }
    
    func getAllShips() -> [Ship] {
        return ships
    }
}
