import Foundation
import Combine

final class ModuleManagementService {
    
    // MARK: - Public Properties
    
    static let shared = ModuleManagementService()
    
    // MARK: - Private Properties
    
    private let allModuleTypes: [ModuleType]
    private var filteredBySlotModuleTypes: [ModuleType] = []
    private var filteredModuleSubTypes: [ModuleSubType] = []
    private var filteredModules: [Module] = []

    
    // MARK: - Init
    
    private init() {
        self.allModuleTypes = MockDataService.shared.loadMockModuleData()
    }
    
    // MARK: - Public Methods
    
    func sortModuleTypeData(selection: ChosenSlotType)  {
        return sortModuleTypes(for: selection)
    }
    
    func getModuleTypes() -> [ModuleType] {
        return filteredBySlotModuleTypes
    }
    
    func getModuleSubTypes(moduleTypeID: UUID) -> [ModuleSubType] {
        self.filteredModuleSubTypes = filteredBySlotModuleTypes.first(where: { $0.id == moduleTypeID } )?.subTypes ?? []
        return filteredModuleSubTypes
    }
    
    func getModule(moduleSubTypeID: UUID) -> [Module] {
        self.filteredModules = filteredModuleSubTypes.first(where: { $0.id == moduleSubTypeID } )?.modules ?? []
        return filteredModules
    }
    // MARK: - Private Methods
    
    private func sortModuleTypes(for selection: ChosenSlotType) {
        let filteredModuleTypes = allModuleTypes.filter { moduleType in
            moduleType.slot == selection.slot
        }
        self.filteredBySlotModuleTypes = filteredModuleTypes
    }
}
