import Foundation

final class MockDataService {
    
    static let shared = MockDataService()
    
    private init() {}
    
    func loadMockModuleData() -> [ModuleType] {
        return [ModuleType(name: "Lasers",
                           slot: .high,
                           subTypes: [ModuleSubType(name: "Small Pulse Lasers",
                                                    modules: [Module(name: "MK9 Small Pulse Laser",
                                                                     moduleImage: "large_Rifled_Railgun")])]),
                ModuleType(name: "Railguns",
                           slot: .high,
                           subTypes: [ModuleSubType(name: "Large Snubnosed Railguns",
                                                    modules: [Module(name: "Core X-Type Large Snubnosed Railguns",
                                                                     moduleImage: "large_Rifled_Railgun")])])]
    }
}
