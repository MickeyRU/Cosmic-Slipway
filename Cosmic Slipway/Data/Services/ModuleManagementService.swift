import Foundation
import Combine

final class ModuleManagementService {
    
    // MARK: - Public Properties
    
    static let shared = ModuleManagementService()
    
    // MARK: - Private Properties
    
    private var moduleTypes: [ModuleType] = []
    private var moduleSubTypes: [ModuleSubType] = []
    private var modules: [Module] = []
    
    // MARK: - Init
    
    private init() {
        loadModules()
    }
    
    // MARK: - Public Methods
    
    func prepareModuleTypesForSlotFitting(selection: ModuleSelection)  {
        return loadModuleFoSelectedSloType(selection: selection)
    }
    
    func getModuleTypes() -> [ModuleType] {
        return moduleTypes
    }
    
    // MARK: - Private Methods
    
    private func loadModules() {
        self.moduleTypes = [
            ModuleType(name: "Lasers", subTypes: []),
            ModuleType(name: "Railguns", subTypes: [
                ModuleSubType(name: "Large Rifled Railguns", modules: [
                    Module(id: UUID(), name: "Core X-Type Large Rifled Railgun", slot: .high, moduleImage: "large_Rifled_Railgun")
                ])
            ]),
            ModuleType(name: "Cannons", subTypes: [])
        ]
    }
    
    private func loadModuleFoSelectedSloType(selection: ModuleSelection) {
        // Фильтрация moduleTypes, чтобы найти те типы модулей, что содержат модули для выбранного слота.
        let filteredModuleTypes = moduleTypes.filter { moduleType in
            moduleType.subTypes.contains { subType in
                subType.modules.contains { module in
                    module.slot == selection.slot
                }
            }
        }
        moduleTypes = filteredModuleTypes
    }
}
