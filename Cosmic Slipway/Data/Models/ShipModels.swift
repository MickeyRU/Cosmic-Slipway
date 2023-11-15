import Foundation

// Структура для хранения данных типа корабля
struct ShipType: Nameable {
    let id: UUID
    let name: String
    let subTypes: [ShipSubtype] // Подтипы корабля
    
    init(id: UUID = UUID(), name: String, subTypes: [ShipSubtype]) {
        self.id = id
        self.name = name
        self.subTypes = subTypes
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
    
    init(id: UUID,
         name: String,
         shipImage: String,
         fitting: Fitting,
         configurationID: UUID = UUID()) {
        self.id = id
        self.name = name
        self.shipImage = shipImage
        self.fitting = fitting
        self.configurationID = configurationID
    }
    
    // Инициализатор для клонирования существующего корабля с новой конфигурацией
    init(cloning ship: Ship,
         withNewFitting fitting: Fitting) {
        self.id = ship.id
        self.name = ship.name
        self.shipImage = ship.shipImage
        self.fitting = fitting
        self.configurationID = UUID() // Новый уникальный ID для новой конфигурации
    }
    
    // Метод для обновления оснащения (fitting) корабля
    func withUpdatedFitting(_ newFitting: Fitting) -> Ship {
        // Создаем новый экземпляр Ship с обновленным оснащением
        return Ship(id: self.id,
                    name: self.name,
                    shipImage: self.shipImage,
                    fitting: newFitting,
                    configurationID: self.configurationID)
    }
}

struct Fitting {
    let configurationID: UUID
    
    let maxHighSlots: Int
    let maxMidSlots: Int
    let maxLowSlots: Int
    let maxCombatRigs: Int
    let maxEngineeringRigs: Int
    
    let highSlots: [Module]
    let midSlots: [Module]
    let lowSlots: [Module]
    let combatRigs: [Module]
    let engineeringRigs: [Module]
    
    init(maxHighSlots: Int,
         maxMidSlots: Int,
         maxLowSlots: Int,
         maxCombatRigs: Int,
         maxEngineeringRigs: Int,
         highSlots: [Module]? = nil,
         midSlots: [Module]? = nil,
         lowSlots: [Module]? = nil,
         combatRigs: [Module]? = nil,
         engineeringRigs: [Module]? = nil)  {
        self.configurationID = UUID()
        self.maxHighSlots = maxHighSlots
        self.maxMidSlots = maxMidSlots
        self.maxLowSlots = maxLowSlots
        self.maxCombatRigs = maxCombatRigs
        self.maxEngineeringRigs = maxEngineeringRigs
        
        self.highSlots = highSlots ?? Array(repeating: Module(id: UUID(), name: "High Slot", moduleImage: "highSlot"), count: maxHighSlots)
        self.midSlots = midSlots ?? Array(repeating: Module(id: UUID(), name: "Mid Slot", moduleImage: "midSlot"), count: maxMidSlots)
        self.lowSlots = lowSlots ?? Array(repeating: Module(id: UUID(), name: "Low Slot", moduleImage: "lowSlot"), count: maxLowSlots)
        self.combatRigs = combatRigs ?? Array(repeating: Module(id: UUID(), name: "Combat Rig", moduleImage: "combatRig"), count: maxCombatRigs)
        self.engineeringRigs = engineeringRigs ?? Array(repeating: Module(id: UUID(), name: "Engineering Rig", moduleImage: "engineerRigs"), count: maxEngineeringRigs)
    }
    
    func updatedFitting(withUpdatedSlot slotType: SlotType, atIndex index: Int, newModule: Module) -> Fitting {
        var newHighSlots = self.highSlots
        var newMidSlots = self.midSlots
        var newLowSlots = self.lowSlots
        var newCombatRigs = self.combatRigs
        var newEngineeringRigs = self.engineeringRigs
        
        switch slotType {
        case .high:
            if index < newHighSlots.count {
                newHighSlots[index] = newModule
            }
        case .mid:
            if index < newMidSlots.count {
                newMidSlots[index] = newModule
            }
        case .low:
            if index < newLowSlots.count {
                newLowSlots[index] = newModule
            }
        case .combatRig:
            if index < newCombatRigs.count {
                newCombatRigs[index] = newModule
            }
        case .engineeringRig:
            if index < newEngineeringRigs.count {
                newEngineeringRigs[index] = newModule
            }
        }
        
        return Fitting(maxHighSlots: self.maxHighSlots,
                       maxMidSlots: self.maxMidSlots,
                       maxLowSlots: self.maxLowSlots,
                       maxCombatRigs: self.maxCombatRigs,
                       maxEngineeringRigs: self.maxEngineeringRigs,
                       highSlots: newHighSlots,
                       midSlots: newMidSlots,
                       lowSlots: newLowSlots,
                       combatRigs: newCombatRigs,
                       engineeringRigs: newEngineeringRigs)
    }
}
