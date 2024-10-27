import Foundation

protocol SkillsIdentifiable: Identifiable {
    var id: UUID { get }
    var title: String { get }
    var imageName: String { get }
}

enum SkillTech: String {
    case basic = "Basic"
    case advanced = "Advanced"
    case expert = "Expert"
}

enum CurrentSkillLevel: Int, Comparable {
    case zero, one, two, three, four, five
    
    static func < (lhs: CurrentSkillLevel, rhs: CurrentSkillLevel) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

enum SkillTierDependency {
    case tier1  // 4-5-0  (basic -> advanced (если basic минимум в 4), advanced -> expert (если advanced минимум в 5)
    
    // Метод для проверки зависимости
    func isSatisfied(for currentTech: SkillTech, basedOn subgroup: SkillsSubGroup) -> Bool {
        switch self {
        case .tier1:
            switch currentTech {
            case .basic:
                return true
            case .advanced:
                return subgroup.basicSkill.currentLvl.rawValue >= 4
            case .expert:
                return subgroup.advancedSkill.currentLvl.rawValue == 5
            }
        }
    }
}

struct SkillsCategory: SkillsIdentifiable {
    let id = UUID()
    var title: String
    var imageName: String
    let learnedPercent: Float
    let learnedSP: Int
    let skillsGroups: [SkillsGroup]
}

struct SkillsGroup: SkillsIdentifiable {
    let id = UUID()
    var title: String
    var imageName: String
    let skillsSubGroups: [SkillsSubGroup]
}

struct SkillsSubGroup: Identifiable {
    let id = UUID()
    var basicSkill: Skill
    var advancedSkill: Skill
    var expertSkill: Skill
    
    // Используем выбранный вариант зависимостей
    let dependency: SkillTierDependency
    
    // Проверка возможности прокачки
    func canLevelUp(from currentTech: SkillTech) -> Bool {
        return dependency.isSatisfied(for: currentTech, basedOn: self)
    }
}

struct Skill: SkillsIdentifiable {
    let id = UUID()
    var title: String
    var imageName: String
    let skillTech: SkillTech
    let experiencePreset: SkillPresetTier
    var currentLvl: CurrentSkillLevel = .zero
    
    // Синхронный метод для получения общего SP до текущего уровня прокачки конкретного скилла
    func getSPforCurrentLVL() -> Int {
        var totalSp: Int = 0
        
        for level in CurrentSkillLevel.zero.rawValue...currentLvl.rawValue {
            if let skillLevel = CurrentSkillLevel(rawValue: level) {
                totalSp += experiencePreset.experienceForLevel(skillTech, skillLevel)
            }
        }
        
        return totalSp
    }
}
