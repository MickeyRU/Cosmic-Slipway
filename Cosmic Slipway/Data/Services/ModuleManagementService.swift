import Foundation
import Combine

final class ModuleManagementService {
    
    // MARK: - Public Properties
    
    static let shared = ModuleManagementService()
    
    // MARK: - Private Properties
    
    private let moduleTypes: [ModuleType]
    private var filteredModuleTypes: [ModuleType] = []
    
    // MARK: - Init
    
    private init() {
        self.moduleTypes = MockDataService.shared.loadMockModuleData()
    }
    
    // MARK: - Public Methods
    
    func prepareModuleTypesForSlotFitting(selection: ModuleSelection)  {
        return loadModuleFoSelectedSloType(selection: selection)
    }
    
    func getModuleTypes() -> [ModuleType] {
        return filteredModuleTypes
    }
    
    // MARK: - Private Methods
    
    private func loadModuleFoSelectedSloType(selection: ModuleSelection) {
        let filteredModuleTypes = moduleTypes.filter { moduleType in
            moduleType.slot == selection.slot
        }
        self.filteredModuleTypes = filteredModuleTypes
    }
}
