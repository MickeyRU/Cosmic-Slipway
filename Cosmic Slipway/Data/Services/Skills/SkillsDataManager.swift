import Foundation

final class SkillsDataManager: ObservableObject {
    @Published private(set) var skillsCategories: [SkillsCategory] = []
    
    init() {
        Task {
            await asyncLoadSkills()
        }
    }
    
    // Асинхронный метод для загрузки данных (например, с сервера или локальных файлов)
    func asyncLoadSkills() async {
        do {
            try await Task.sleep(for: .seconds(5))
            
            await MainActor.run {
                self.skillsCategories = testSkills  // Используем тестовый список
            }
        } catch {
            print("Ошибка загрузки данных: \(error)")
        }
    }
}
