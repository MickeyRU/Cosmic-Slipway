import Foundation

enum SkillChangeError: Error {
    case invalidSubGroup
    case dependencyNotSatisfied
    case invalidSkillTech
}

final class SkillsDataManager: ObservableObject {
    @Published private(set) var skillsCategories: [SkillsCategory] = []
    
    init() {
        Task {
            await asyncLoadSkills()
        }
    }
    
    func tryAsyncChangeSkillLevel(subGroupId: UUID, skillTech: SkillTech, increase: Bool) async throws -> Bool {
            for categoryIndex in skillsCategories.indices {
                for groupIndex in skillsCategories[categoryIndex].skillsGroups.indices {
                    if let subGroupIndex = skillsCategories[categoryIndex].skillsGroups[groupIndex].skillsSubGroups.firstIndex(where: { $0.id == subGroupId }) {
                        
                        // Выполняем изменения на главном потоке с корректной обработкой ошибок
                        return try await MainActor.run { () -> Bool in
                            let subGroup = skillsCategories[categoryIndex].skillsGroups[groupIndex].skillsSubGroups[subGroupIndex]
                            let canChangeLevel = increase ? subGroup.canLevelUp(from: skillTech) : subGroup.canLevelDown(from: skillTech)
                            
                            guard canChangeLevel else {
                                throw SkillChangeError.dependencyNotSatisfied
                            }
                            
                            // Изменение уровня навыка
                            skillsCategories[categoryIndex].skillsGroups[groupIndex].skillsSubGroups[subGroupIndex].changeSkillLevel(for: skillTech, increase: increase)
                            return true
                        }
                    }
                }
            }
            
            throw SkillChangeError.invalidSubGroup
        }
    
    // Пример асинхронного метода загрузки данных
    private func asyncLoadSkills() async {
        do {
            try await Task.sleep(for: .seconds(5))
            await MainActor.run {
                self.skillsCategories = testSkills  // Инициализация тестовыми данными
            }
        } catch {
            print("Ошибка загрузки данных: \(error)")
        }
    }
}

extension SkillsDataManager {
    func getSubGroups(for groupId: UUID) -> [SkillsSubGroup]? {
        return skillsCategories
            .flatMap { $0.skillsGroups }
            .first { $0.id == groupId }?
            .skillsSubGroups
    }
}
