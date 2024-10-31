import Foundation

enum SkillChangeError: Error {
    case invalidSubGroup
    case dependencyNotSatisfied
}

final class SkillsDataManager: ObservableObject {
    @Published private(set) var skillsCategories: [SkillsCategory] = []
    
    init() {
        Task {
            await asyncLoadSkills()
        }
    }
    
    func tryAsyncChangeSkillLevel(subGroupId: UUID, skillTech: SkillTech, increase: Bool) async throws {
        guard let indices = findSubGroup(by: subGroupId) else {
            throw SkillChangeError.invalidSubGroup
        }
        
        try await MainActor.run {
            try self.changeSkillLevel(at: indices, skillTech: skillTech, increase: increase)
        }
    }
    
    private func findSubGroup(by subGroupId: UUID) -> (categoryIndex: Int, groupIndex: Int, subGroupIndex: Int)? {
        for categoryIndex in skillsCategories.indices {
            for groupIndex in skillsCategories[categoryIndex].skillsGroups.indices {
                if let subGroupIndex = skillsCategories[categoryIndex].skillsGroups[groupIndex].skillsSubGroups.firstIndex(where: { $0.id == subGroupId }) {
                    return (categoryIndex, groupIndex, subGroupIndex)
                }
            }
        }
        return nil
    }
    
    
    @MainActor
    private func changeSkillLevel(at indices: (categoryIndex: Int, groupIndex: Int, subGroupIndex: Int),
                                  skillTech: SkillTech,
                                  increase: Bool) throws {
        let subGroup = skillsCategories[indices.categoryIndex].skillsGroups[indices.groupIndex].skillsSubGroups[indices.subGroupIndex]
        
        let canChangeLevel = increase ? subGroup.canLevelUp(from: skillTech) : subGroup.canLevelDown(from: skillTech)
        guard canChangeLevel else {
            throw SkillChangeError.dependencyNotSatisfied
        }
        
        // Изменение уровня навыка
        skillsCategories[indices.categoryIndex].skillsGroups[indices.groupIndex].skillsSubGroups[indices.subGroupIndex].changeSkillLevel(for: skillTech, increase: increase)
    }
    
    // Заглушка асинхронного метода загрузки данных
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

// Mark: - extension SkillsDataManager

extension SkillsDataManager {
    func getSubGroups(for groupId: UUID) -> [SkillsSubGroup]? {
        return skillsCategories
            .flatMap { $0.skillsGroups }
            .first { $0.id == groupId }?
            .skillsSubGroups
    }
}
