import Foundation
import Combine

final class SkillCategoriesViewModel: ObservableObject {
    @Published private(set) var skillCategories: [SkillsCategory] = []
    
    private var cancellables = Set<AnyCancellable>()  // Для хранения подписок
    private let skillsDataManager: SkillsDataManager

    init(skillsDataManager: SkillsDataManager) {
        self.skillsDataManager = skillsDataManager
        bindToDataManager()
    }

    // Привязываем skillGroups к изменениям в skillsDataManager
    private func bindToDataManager() {
        skillsDataManager.$skillsCategories
            .receive(on: DispatchQueue.main)  // Обновление на главном потоке
            .assign(to: \.skillCategories, on: self)
            .store(in: &cancellables)
    }
}
