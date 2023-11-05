import Foundation

// Структура для хранения данных типа корабля
struct ShipType: Nameable {
    let id: UUID
    let name: String
    let subtypes: [ShipSubtype] // Подтипы корабля
    
    init(id: UUID = UUID(), name: String, subtypes: [ShipSubtype]) {
        self.id = id
        self.name = name
        self.subtypes = subtypes
    }
}

// Структура для хранения данных подтипа корабля
struct ShipSubtype: Nameable {
    let id: UUID
    let name: String
    let ships: [Ship] // Корабли подтипа
    
    init(id: UUID = UUID(), name: String, ships: [Ship]) {
        self.id = id
        self.name = name
        self.ships = ships
    }
}

// Структура для хранения данных конкретного корабля
struct Ship: Nameable {
    let id: UUID
    let name: String
    let shipImage: String
    let fitting: Fitting // Модули корабля
    let configurationID: UUID // Уникальный ID конкретной конфигурации корабля
    
    
    init(id: UUID, name: String, shipImage: String, fitting: Fitting, configurationID: UUID = UUID()) {
        self.id = id
        self.name = name
        self.shipImage = shipImage
        self.fitting = fitting
        self.configurationID = configurationID
    }
    
    // Инициализатор для клонирования существующего корабля с новой конфигурацией
    init(cloning ship: Ship, withNewFitting fitting: Fitting) {
        self.id = ship.id
        self.name = ship.name
        self.shipImage = ship.shipImage
        self.fitting = fitting
        self.configurationID = UUID() // Новый уникальный ID для новой конфигурации
    }
}

// Структура для хранения оснащения корабля
struct Fitting {
    let highSlots: Int
    let midSlots: Int
    let lowSlots: Int
    let combatRigs: Int
    let engineeringRigs: Int
}
