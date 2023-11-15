import Foundation

final class MockDataService {
    
    static let shared = MockDataService()
    
    private init() {}
    
    func loadMockShipsData() -> [ShipType]{
        return [ShipType(name: "Frigates", subTypes: []),
                ShipType(name: "Destroyers", subTypes: []),
                ShipType(name: "Cruisers", subTypes: []),
                ShipType(name: "Battlecruisers", subTypes: []),
                ShipType(name: "Industrial Ships", subTypes: []),
                ShipType(name: "Battleships", subTypes: [ShipSubtype(name: "Battleships", ships: []),
                                                         ShipSubtype(name: "Siege Battleships", ships: [
                                                            Ship(id: UUID(), name: "Megathron Striker",
                                                                 shipImage: "megathronStriker",
                                                                 fitting: Fitting(maxHighSlots: 2,
                                                                                  maxMidSlots: 2,
                                                                                  maxLowSlots: 2,
                                                                                  maxCombatRigs: 2,
                                                                                  maxEngineeringRigs: 2))])]),
                ShipType(name: "Capital Ships", subTypes: [])
        ]
    }
    
    func loadMockModuleData() -> [ModuleType] {
        return [ModuleType(name: "Lasers",
                           slot: .high,
                           subTypes: [ModuleSubType(name: "Small Pulse Lasers",
                                                    modules: [Module(name: "MK9 Small Pulse Laser",
                                                                     moduleImage: "large_Rifled_Railgun")]),
                                      ModuleSubType(name: "Medium Pulse Lasers",
                                                    modules: [Module(name: "MK9 Medium Pulse Laser",
                                                                     moduleImage: "large_Rifled_Railgun")])]),
                ModuleType(name: "Railguns",
                           slot: .high,
                           subTypes: [ModuleSubType(name: "Large Snubnosed Railguns",
                                                    modules: [Module(name: "Core X-Type Large Snubnosed Railguns",
                                                                     moduleImage: "large_Rifled_Railgun"),
                                                              Module(name: "Core A-Type Large Snubnosed Railguns", 
                                                                     moduleImage: "large_Rifled_Railgun")])]),
                ModuleType(name: "Energy Neutralaizer",
                           slot: .mid,
                           subTypes: [ModuleSubType(name: "Large Energy Neutralizers",
                                                    modules: [Module(name: "'Moat' Large Energy Neutralizer",
                                                                     moduleImage: "large_Rifled_Railgun")])])
        ]
    }
}
