import Foundation
import Combine

struct ModuleForUpdate {
    let moduleID: UUID
    let chosenSlotType: SlotAndIndex
}

final class ModuleManagementService {
    
    // MARK: - Public Properties
    
    static let shared = ModuleManagementService()
    
    @Published var moduleForUpdate: ModuleForUpdate?
    
    // MARK: - Private Properties
    
    private let allModuleTypes: [ModuleType]
    private var filteredBySlotModuleTypes: [ModuleType] = []
    private var filteredModuleSubTypes: [ModuleSubType] = []
    private var filteredModules: [Module] = []
    
    private var selectedSlot: SlotAndIndex?

    // MARK: - Init
    
    private init() {
        self.allModuleTypes = MockDataService.shared.loadMockModuleData()
    }
    
    // MARK: - Public Methods
    
    func sortModuleTypeData(selection: SlotAndIndex)  {
        self.selectedSlot = selection
        return sortModuleTypes(for: selection)
    }
    
    func getModuleTypes() -> [ModuleType] {
        return filteredBySlotModuleTypes
    }
    
    func getModuleSubTypes(moduleTypeID: UUID) -> [ModuleSubType] {
        self.filteredModuleSubTypes = filteredBySlotModuleTypes.first(where: { $0.id == moduleTypeID } )?.subTypes ?? []
        return filteredModuleSubTypes
    }
    
    func sortModuleFromSubTypes(moduleSubTypeID: UUID) -> [Module] {
        self.filteredModules = filteredModuleSubTypes.first(where: { $0.id == moduleSubTypeID } )?.modules ?? []
        return filteredModules
    }
    
    func getModule(byID: UUID) -> Module {
        guard let module = filteredModules.first(where: {$0.id == byID }) else {
            print("Ошибка получения Модуля")
            fatalError()
        }
        return module
    }
    
    func userSelectModule(moduleID: UUID) {
        guard let slot = self.selectedSlot else {
            print("Ошибка получения слота")
            return
        }
        let module = ModuleForUpdate(moduleID: moduleID, chosenSlotType: slot)
        self.moduleForUpdate = module
    }
    
    // MARK: - Private Methods
    
    private func sortModuleTypes(for selection: SlotAndIndex) {
        let filteredModuleTypes = allModuleTypes.filter { moduleType in
            moduleType.slot == selection.slot
        }
        self.filteredBySlotModuleTypes = filteredModuleTypes
    }
}
