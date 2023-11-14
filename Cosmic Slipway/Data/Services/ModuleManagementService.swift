import Foundation
import Combine

final class ModuleManagementService {
    
    // MARK: - Public Properties
    
    static let shared = ModuleManagementService()
    
    // MARK: - Private Properties
    
    private let moduleTypes: [ModuleType]
    private var filteredModuleTypes: [ModuleType] = []
    private var moduleSubTypes: [ModuleSubType] = []
    
    // MARK: - Init
    
    private init() {
        self.moduleTypes = MockDataService.shared.loadMockModuleData()
    }
    
    // MARK: - Public Methods
    
    func sortModuleTypeData(selection: ChosenSlotType)  {
        return sort(for: selection)
    }
    
    func getModuleTypes() -> [ModuleType] {
        return filteredModuleTypes
    }
    
    func getModuleSubTypes(moduleTypeID: UUID) -> [ModuleSubType] {
        return moduleSubTypes
    }
    
    // MARK: - Private Methods
    
    private func sort(for selection: ChosenSlotType) {
        let filteredModuleTypes = moduleTypes.filter { moduleType in
            moduleType.slot == selection.slot
        }
        self.filteredModuleTypes = filteredModuleTypes
    }
}
