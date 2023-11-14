import Foundation

enum SlotType {
    case high
    case mid
    case low
    case combatRig
    case engineeringRig
}

struct ModuleType: Nameable {
    let id: UUID
    let name: String
    let slot: SlotType
    var subTypes: [ModuleSubType]
    
    init(id: UUID = UUID(), name: String, slot: SlotType, subTypes: [ModuleSubType]) {
        self.id = id
        self.name = name
        self.slot = slot
        self.subTypes = subTypes
    }
}

struct ModuleSubType: Nameable {
    let id: UUID
    let name: String
    var modules: [Module]
    
    init(id: UUID = UUID(), name: String, modules: [Module]) {
        self.id = id
        self.name = name
        self.modules = modules
    }
}

struct Module: Nameable {
    let id: UUID
    let name: String
    let moduleImage: String
    
    init(id: UUID = UUID(), name: String , moduleImage: String) {
        self.id = id
        self.name = name
        self.moduleImage = moduleImage
    }
}
