import Foundation

class ShipDataService {
    static let shared = ShipDataService()
    
    // Массивы для хранения данных о кораблях
    private var shipTypes: [ShipType]
    
    private init() {
        // Инициализация массивов данными, например, заглушками
        self.shipTypes = [
            ShipType(name: "Frigates", subtypes: []),
            ShipType(name: "Destroyers", subtypes: []),
            ShipType(name: "Cruisers", subtypes: []),
            ShipType(name: "Battlecruisers", subtypes: []),
            ShipType(name: "Industrial Ships", subtypes: []),
            ShipType(name: "Battleships", subtypes: [ShipSubtype(name: "BattleShips", ships: []),
                                                    ShipSubtype(name: "Siege BattlesShips", ships: [])]),
            ShipType(name: "Capital Ships", subtypes: [])
        ]
    }
    
    func getAllShipTypes() -> [ShipType] {
        return shipTypes
    }
    
    func getShipSubtypes(forShipTypeId shipTypeId: UUID) -> [ShipSubtype] {
        return shipTypes.first(where: { $0.id == shipTypeId })?.subtypes ?? []
    }
}
