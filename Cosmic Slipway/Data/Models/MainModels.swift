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
    var fitting: Fitting // Модули корабля
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
    
    // Метод для обновления оснащения (fitting) корабля
    func withUpdatedFitting(_ newFitting: Fitting) -> Ship {
        // Создаем новый экземпляр Ship с обновленным оснащением
        return Ship(id: self.id, name: self.name, shipImage: self.shipImage, fitting: newFitting, configurationID: self.configurationID)
    }
}

// Модули - которые будем фитить
struct Module: Nameable {
    let id: UUID
    let name: String
    let type: ModuleType
}

enum ModuleType {
    case high
    case mid
    case low
    case combatRig
    case engineeringRig
}

// Структура для хранения оснащения корабля

struct Fitting {
    var highSlots: [Module]
    var midSlots: [Module]
    var lowSlots: [Module]
    var combatRigs: [Module]
    var engineeringRigs: [Module]

    let maxHighSlots: Int // Максимальное количество высоких слотов
    let maxMidSlots: Int // Максимальное количество средних слотов
    let maxLowSlots: Int // Максимальное количество низких слотов
    let maxCombatRigs: Int // Максимальное количество боевых ригов
    let maxEngineeringRigs: Int // Максимальное количество инженерных ригов

    // Инициализатор, который устанавливает начальные значения слотов на основе максимальных значений.
    init(maxHighSlots: Int, maxMidSlots: Int, maxLowSlots: Int, maxCombatRigs: Int, maxEngineeringRigs: Int) {
        self.maxHighSlots = maxHighSlots
        self.maxMidSlots = maxMidSlots
        self.maxLowSlots = maxLowSlots
        self.maxCombatRigs = maxCombatRigs
        self.maxEngineeringRigs = maxEngineeringRigs

        highSlots = Array(repeating: Module(id: UUID(), name: "Empty", type: .high), count: maxHighSlots)
        midSlots = Array(repeating: Module(id: UUID(), name: "Empty", type: .mid), count: maxMidSlots)
        lowSlots = Array(repeating: Module(id: UUID(), name: "Empty", type: .low), count: maxLowSlots)
        combatRigs = Array(repeating: Module(id: UUID(), name: "Empty", type: .combatRig), count: maxCombatRigs)
        engineeringRigs = Array(repeating: Module(id: UUID(), name: "Empty", type: .engineeringRig), count: maxEngineeringRigs)
    }
}
