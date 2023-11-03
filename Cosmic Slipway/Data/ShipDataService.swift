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
            ShipType(name: "Frigates", subtypes: []),
            ShipType(name: "Destroyers", subtypes: []),
            ShipType(name: "Cruisers", subtypes: []),
            ShipType(name: "Battlecruisers", subtypes: []),
            ShipType(name: "Industrial Ships", subtypes: []),
            ShipType(name: "Battleships", subtypes: []),
            ShipType(name: "Capital Ships", subtypes: [])
        ]
        
        self.shipSubtypes = [
            ShipSubtype(name: "Subtype 1", ships: []),
            ShipSubtype(name: "Subtype 2", ships: [])
        ]
        
        self.ships = [
            Ship(name: "Ship 1", shipImage: "ship1", fitting: Fitting(highSlots: 4, midSlots: 3, lowSlots: 5, combatRigs: 2, engineeringRigs: 1)),
            Ship(name: "Ship 2", shipImage: "ship2", fitting: Fitting(highSlots: 5, midSlots: 4, lowSlots: 3, combatRigs: 1, engineeringRigs: 2))
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
