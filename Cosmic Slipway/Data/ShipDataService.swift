import Foundation

class ShipDataService {
    static let shared = ShipDataService()
    
    // Массивы для хранения данных о кораблях
    private var shipTypes: [ShipType]
    
    private var shipSubTypes: [ShipSubtype] = []
    
    private var ships: [Ship] = []
    
    private init() {
        // Инициализация массивов данными, например, заглушками
        self.shipTypes = [
            ShipType(name: "Frigates", subtypes: []),
            ShipType(name: "Destroyers", subtypes: []),
            ShipType(name: "Cruisers", subtypes: []),
            ShipType(name: "Battlecruisers", subtypes: []),
            ShipType(name: "Industrial Ships", subtypes: []),
            ShipType(name: "Battleships", subtypes: [ShipSubtype(name: "Battleships", ships: []),
                                                     ShipSubtype(name: "Siege Battleships", ships: [
                                                        Ship(name: "Megathron Striker",
                                                             shipImage: "megathronStriker",
                                                             fitting: Fitting(highSlots: 7,
                                                                              midSlots: 7,
                                                                              lowSlots: 7,
                                                                              combatRigs: 7,
                                                                              engineeringRigs: 7))
                                                     ])
                                                    ]),
            ShipType(name: "Capital Ships", subtypes: [])
        ]
    }
    
    func getAllShipTypes() -> [ShipType] {
        return shipTypes
    }
    
    func getShipSubtypes(forShipTypeID shipTypeID: UUID) -> [ShipSubtype] {
        self.shipSubTypes = shipTypes.first(where: { $0.id == shipTypeID })?.subtypes ?? []
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
}
